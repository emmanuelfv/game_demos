import 'package:flutter/material.dart';
import 'package:tic_tac_toe/config/app_theme.dart';
import 'package:tic_tac_toe/widgets-common/auth_widget.dart';

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
      home: const AuthScreen(),
    );
  }
}


