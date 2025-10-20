/*
import 'package:flutter/material.dart';
import 'package:game_demos/services/websocket/websocket_service.dart';

class GameScreen extends StatefulWidget {
  final String gameType;
  const GameScreen({super.key, required this.gameType});

    State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final WebSocketService _webSocketService;
  Map<String, dynamic>? _currentGameState;
  bool _isGameReady = false;

  
  void initState() {
    super.initState();
    _webSocketService = WebSocketService();

    // 1. Listen for game state updates from the server
    _webSocketService.gameStateStream.listen((gameState) {
      setState(() {
        _currentGameState = gameState;
      });
    });

    // 2. Set the callback for when the game is ready to start
    _webSocketService.onGameStart = (initialGameState) {
      print("Game is starting!");
      setState(() {
        _currentGameState = initialGameState;
        _isGameReady = true;
      });
    }; 

    // 3. Activate the connection
    _webSocketService.activate();
    
    // 4. Join the specific game
    // You might delay this call until after the WebSocket is fully connected
    // for more robustness, but the service handles the subscription logic internally.
    _webSocketService.joinGame(widget.gameType);
  }

  
  void dispose() {
    // 5. Clean up the connection when the screen is removed
    _webSocketService.deactivate();
    super.dispose();
  }

  void _handlePlayerMove(String move) {
    // 6. Send the player's move to the server
    _webSocketService.makeMove(move);
  }

  
  Widget build(BuildContext context) {
    if (!_isGameReady) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Build your game UI using the _currentGameState
    // For example, display the board, current turn, etc.
    // And call _handlePlayerMove() on user interaction.
    return Scaffold(
      appBar: AppBar(title: Text(widget.gameType)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Game ID: ${_currentGameState?['gameId']}'),
            Text('Turn: ${_currentGameState?['turn']}'),
            // ... Your game board widget ...
          ],
        ),
      ),
    );
  }
}
*/