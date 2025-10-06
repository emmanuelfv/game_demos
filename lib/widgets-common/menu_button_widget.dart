import 'package:flutter/material.dart';
import 'package:game_demos/config/app_theme.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MenuButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.appBarColor,
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: AppTheme.textStyleTitle,
          ),
        ),
      ),
    );
  }
}