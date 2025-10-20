import 'dart:convert';
import 'dart:io';

import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:game_demos/config/api_config.dart';
import 'dart:math';

/*
void onConnect(StompFrame frame) {
  stompClient.subscribe(
    destination: '/game_backend/join',
    callback: (frame) {
      if (frame.body != null) {
        Map<String, dynamic> message = json.decode(frame.body!);
        print('Received message: $message');
      }
    },
  );

  String random1 = '${Random().nextInt(100)}';
  String s = json.encode({'message': random1});
  print(s);
  stompClient.send(
    destination: '/game_frontend/join',
    body: s,
    headers: {},
  );
}*/

String? _gameId;
String? playerId;
String? turn;
//final _gameStateController = StreamController<Map<String, dynamic>>.broadcast();

final stompClient = StompClient(
  config: StompConfig(
    url: 'ws://192.168.50.151:8080/ws_game',
    onConnect: onConnect,
    onWebSocketError: (dynamic error) => print(error.toString()),
  ),
);

void onConnect(StompFrame frame) {
  // Both users subscribe to the /join topic to get the gameId
  stompClient.subscribe(
    destination: '/game_backend/join',
    callback: (frame) {
      if (frame.body != null) {
        print('Received join message: ${frame.body}');
        final body = json.decode(frame.body!);
        if (body['userName'] != ApiConfig.user) {
          return;
        }
        if (body['errorMessage'] != null) {
          print('Error joining game: ${body['errorMessage']}');
          return;
        }

        _gameId = body['gameId'];
        playerId = body['playerId'];
        turn = body['turn'];
        _subscribeToGameChannel(_gameId!);
        if(('x,o').contains(turn!)) {
          print('Game started with initial state: $body');

          //Map<String, dynamic> gameState = {
          //  'gameId': _gameId,
          //  'turn': turn,
          //  'playerId': playerId,
          //  'board': List.generate(7, (index) => List.filled(6, '_')),  //TODO: connect4 board, to change to generalized
          //  'endGame': ''
          //};
          //onGameStart?.call(gameState);
          //_gameStateController.add(gameState);
        }
      }
    },
  );

  joinGame("connect4"); // TODO: remove this line
}

void _subscribeToGameChannel(String gameId) {
  print('Subscribing to game channel: /game_backend/$gameId');
  stompClient.subscribe(
    destination: '/game_backend/$gameId',
    callback: (frame) {
      if (frame.body != null) {
        final gameState = json.decode(frame.body!);
        print('Received game message: $gameState');
        //onGameStart?.call(gameState);
        //_gameStateController.add(gameState);

        if(gameState['endGame'] != '_') {
          print('Game ended: ${gameState['endGame']}');
        }
        if(gameState['turn'] != turn) {
          turn = gameState['turn'];
          print('Turn changed to: $turn');
        }
        if(turn == (playerId == 'p1' ? 'x' : 'o')) {
          print('It is now your turn, player $playerId');
          makeMove('3'); 
         }

        
      }
    },
  );

  makeMove('3'); // TODO: remove this line
}

void joinGame(String gameType) {
  Map<String, String> joinGameRequest = {
    'userName': ApiConfig.user,
    'token': ApiConfig.token,
    'gameType': gameType
  };
  print('Joining game with request: $joinGameRequest');
  stompClient.send(
    destination: '/game_frontend/join',
    body: json.encode(joinGameRequest),
  );
}

void makeMove(String move) { // Use your actual GameMove object
  if (_gameId == null) {
    print('Error: Cannot make a move without a gameId.');
    return;
  }

  Map<String, String> makeMoveRequest = {
    'gameId': _gameId!,
    'playerId': playerId!,
    'token': ApiConfig.token,
    'value': move,
  };
  print('Making move with request: $makeMoveRequest');
  stompClient.send(
    destination: '/game_frontend/move/$_gameId',
    body: json.encode(makeMoveRequest), // Assumes your move object can be JSON encoded
  );
}



/*
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
  String? playerId;
  String? turn;
  final _gameStateController = StreamController<Map<String, dynamic>>.broadcast();

  Function? onConnected;
  
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
          if (body['userName'] != ApiConfig.user) {
            return;
          }
          if (body['errorMessage'] != null) {
            print('Error joining game: ${body['errorMessage']}');
            return;
          }

          _gameId = body['gameId'];
          playerId = body['playerId'];
          turn = body['turn'];
          _subscribeToGameChannel(_gameId!);
          if(('x,o').contains(turn!)) {
            print('Game started with initial state: $body');

            Map<String, dynamic> gameState = {
              'gameId': _gameId,
              'turn': turn,
              'playerId': playerId,
              'board': List.generate(7, (index) => List.filled(6, '_')),  //TODO: connect4 board, to change to generalized
              'endGame': ''
            };
            onGameStart?.call(gameState);
            _gameStateController.add(gameState);
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
          final gameState = json.decode(frame.body!);
          print('Received game message: $gameState');
          onGameStart?.call(gameState);
          _gameStateController.add(gameState);
        }
      },
    );
  }

  /// Call this when a user wants to join a game
  void joinGame(String gameType) {
    Map<String, String> joinGameRequest = {
      'user': ApiConfig.user,
      'token': ApiConfig.token,
      'gameType': gameType
    };
    _stompClient.send(
      destination: '/game_frontend/join',
      body: json.encode(joinGameRequest),
    );
  }

  /// Call this to send a player's move to the server
  void makeMove(String move) { // Use your actual GameMove object
    if (_gameId == null) {
      print('Error: Cannot make a move without a gameId.');
      return;
    }

    Map<String, String> makeMoveRequest = {
      'gameId': _gameId!,
      'playerId': ApiConfig.user,
      'token': ApiConfig.token,
      'value': move,
    };
    
    _stompClient.send(
      destination: '/game_frontend/move',
      body: json.encode(makeMoveRequest), // Assumes your move object can be JSON encoded
    );
  }
}
*/

