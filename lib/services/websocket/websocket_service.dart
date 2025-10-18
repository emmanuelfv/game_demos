import 'dart:async';
import 'dart:convert';

import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:game_demos/config/api_config.dart';

// TODO: Create data models for your game objects
// For example:
// class GameMove {
//   final String gameId;
//   final int player;
//   final int move;
//   GameMove({required this.gameId, required this.player, required this.move});
//   Map<String, dynamic> toJson() => {'gameId': gameId, 'player': player, 'move': move};
// }

class WebSocketService {
  late final StompClient _stompClient;
  String? _gameId;
  final _gameStateController = StreamController<Map<String, dynamic>>.broadcast();
  
  // Callback to notify the UI that the game can start
  Function(Map<String, dynamic> initialGameState)? onGameStart;

  Stream<Map<String, dynamic>> get gameStateStream => _gameStateController.stream;

  WebSocketService() {
    _stompClient = StompClient(
      config: StompConfig(
        url: ApiConfig.wsUrl,
        onConnect: _onConnect,
        onWebSocketError: (dynamic error) => print('WebSocket Error: $error'),
        onStompError: (StompFrame frame) => print('Stomp Error: ${frame.body}'),
      ),
    );
  }

  void activate() {
    _stompClient.activate();
  }

  void deactivate() {
    _stompClient.deactivate();
    _gameStateController.close();
  }

  void _onConnect(StompFrame frame) {
    // Both users subscribe to the /join topic to get the gameId
    _stompClient.subscribe(
      destination: '/game_backend/join',
      callback: (frame) {
        if (frame.body != null) {
          final body = json.decode(frame.body!);
          _gameId = body['gameId'];
          print('Received Game ID: $_gameId');

          if (_gameId != null) {
            _subscribeToGameChannel(_gameId!);
          }
        }
      },
    );
  }

  void _subscribeToGameChannel(String gameId) {
    print('Subscribing to game channel: /game_backend/$gameId');
    _stompClient.subscribe(
      destination: '/game_backend/$gameId',
      callback: (frame) {
        if (frame.body != null) {
          final message = json.decode(frame.body!);
          print('Received game message: $message');

          // Check if this is the message for user1 to start the game
          if (message['status'] == 'STARTING') { // Assuming the server sends a status
            onGameStart?.call(message);
          } else {
            // For all other game updates (e.g., after a move)
            _gameStateController.add(message);
          }
        }
      },
    );
  }

  /// Call this when a user wants to join a game
  void joinGame({String? token}) {
    // The destination '/app/join' corresponds to the @MessageMapping("/join")
    _stompClient.send(
      destination: '/app/join',
      body: json.encode({'token': token}), // Your GameLogin object
    );
  }

  /// Call this to send a player's move to the server
  void makeMove(dynamic move) { // Use your actual GameMove object
    if (_gameId == null) {
      print('Error: Cannot make a move without a gameId.');
      return;
    }
    // The destination '/app/move' corresponds to the @MessageMapping("/move")
    _stompClient.send(
      destination: '/app/move',
      body: json.encode(move), // Assumes your move object can be JSON encoded
    );
  }
}