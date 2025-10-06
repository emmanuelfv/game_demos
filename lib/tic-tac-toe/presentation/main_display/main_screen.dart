import 'package:flutter/material.dart';
import 'package:game_demos/tic-tac-toe/presentation/grid/grid_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tic-tac-toe',
      debugShowCheckedModeBanner: false,
      home: TicTacToeScreen(),
    );
  }
}

