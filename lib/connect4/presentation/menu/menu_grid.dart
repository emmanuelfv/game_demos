import 'package:flutter/material.dart';
import 'package:game_demos/widgets-common/menu_button_widget.dart';
import 'package:game_demos/connect4/presentation/grid/grid_screen.dart';
import 'package:game_demos/services/websocket/websocket_service.dart';


class Connect4MenuScreen extends StatelessWidget {
  const Connect4MenuScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('connect 4 Menu'),
      ),
      body: Column(
        children: [
          MenuButton(
            text: 'Connect 4 local',
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const Connect4Screen())
              );
            },
          ),
          MenuButton(
            text: 'Connect 4 online',
            onPressed: () {
              stompClient.activate();
            },
          ),
          MenuButton(
            text: 'Connect 4 1P',
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const Connect4Screen())
              );
            },
          ),
        ],
      ),
    );
  }
}
