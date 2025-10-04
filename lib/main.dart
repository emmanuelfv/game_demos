import 'package:flutter/material.dart';
import 'package:tic_tac_toe/config/app_theme.dart';
import 'package:tic_tac_toe/widgets-common/menu_button_widget.dart';
import 'package:tic_tac_toe/tic-tac-toe/presentation/grid/grid_screen.dart';
import 'package:tic_tac_toe/connect4/presentation/grid/grid_screen.dart';
import 'package:tic_tac_toe/checkers/presentation/grid_screen.dart';
import 'package:tic_tac_toe/water_sort/presentation/grid_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tic-tac-toe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppTheme.scaffoldBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: AppTheme.appBarColor,
          titleTextStyle: AppTheme.textStyleTitle,
        ),
      ),
      home: const MenuScreen(),
    );
  }
}

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

