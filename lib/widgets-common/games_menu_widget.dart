import 'package:flutter/material.dart';
import 'package:game_demos/widgets-common/menu_button_widget.dart';
import 'package:game_demos/tic-tac-toe/presentation/grid/grid_screen.dart';
import 'package:game_demos/connect4/presentation/grid/grid_screen.dart';
import 'package:game_demos/checkers/presentation/grid_screen.dart';
import 'package:game_demos/water_sort/presentation/grid_screen.dart';


class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe Menu'),
      ),
      body: Column(
        children: [
          MenuButton(
            text: 'Tic Tac Toe',
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const TicTacToeScreen())
              );
            },
          ),
          MenuButton(
            text: 'Connect 4',
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const Connect4Screen())
              );
            },
          ),
          MenuButton(
            text: 'Checkers',
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const CheckersScreen())
              );
            },
          ),
          MenuButton(
            text: 'Water Sort',
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const WaterSortScreen())
              );
            },
          ),
        ],
      ),
    );
  }
}
