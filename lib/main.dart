/*
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/tic-tac-toe/presentation/grid/grid_screen.dart';

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
}*/

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/checkers/presentation/grid_screen.dart';
import 'package:tic_tac_toe/tic-tac-toe/presentation/grid/grid_screen.dart';
import 'package:tic_tac_toe/tic-tac-toe/config/app_theme.dart';
import 'connect4/presentation/grid/grid_screen.dart';

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
          Padding(padding: EdgeInsets.all(20.0)),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.appBarColor,
              ),
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const TicTacToeScreen())
                );
              },
              child: Text(
                'Tic Tac Toe',
                style: AppTheme.textStyleTitle,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(20.0)),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.appBarColor,
              ),
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const Connect4Screen())
                );
              },
              child: Text(
                'Connect 4',
                style: AppTheme.textStyleTitle,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(20.0)),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.appBarColor,
              ),
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const CheckersScreen())
                );
              },
              child: Text(
                'Checkers',
                style: AppTheme.textStyleTitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}