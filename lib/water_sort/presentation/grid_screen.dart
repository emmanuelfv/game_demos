
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/water_sort/domain/water_sort_game.dart';
import 'package:tic_tac_toe/config/app_theme.dart';

class WaterSortScreen extends StatefulWidget {
  const WaterSortScreen({super.key});

  @override
  State<WaterSortScreen> createState() => WaterSortState();
}


class WaterSortState extends State<WaterSortScreen> {
  final WaterSortGame game = WaterSortGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.appBarColor,
        title: Text('Checkers', style: AppTheme.textStyleTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text("Scoreboard:", style: AppTheme.textStyleTitle),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Container(
              alignment: Alignment.center,
              child: Text("Player o: ${game.playerOWins}", style: AppTheme.textStyleTitle),
            ),
            Padding(padding: EdgeInsets.all(3.0)),
            Container(
              alignment: Alignment.center,
              child: Text("Player x: ${game.playerXWins}", style: AppTheme.textStyleTitle),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 8*8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8), 
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      await _handleTap(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppTheme.gridBorderColor
                        )
                      ),
                      child: Center(
                        child: Text(
                          "0",
                          style: AppTheme.textStyleSign
                        ),
                      ),
                    ),
                  );
                }
              ),
            ), 
            Container(
              alignment: Alignment.topCenter,
              child: Text("Current Turn: ${game.ohTurn ? "O" : "X"}", style: AppTheme.textStyleTitle),
            ),
            Padding(padding: EdgeInsets.all(95.0)),
            Container(
              alignment: Alignment.center,
              child: Text("Checkers, by Emmanuel Felix", style: AppTheme.textStyleTitle),
            )
          ],
        ),
      )
    );
  }

  Future<void> _handleTap(int index) async {
    final resultMessage = game.tapped(index);
    setState(() {});
    if (resultMessage != null) {
      await _endGameDialog(resultMessage);
    }
  }

  Future<void> _endGameDialog(String endGameMessage) async {
    await showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(endGameMessage, style: AppTheme.textStyleEndGame),
          backgroundColor: AppTheme.dialogBackgroundColor,
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  game.clearBoard();
                });
                Navigator.of(context).pop();
              }, 
              child: Text("play again?", style: AppTheme.textStyleEndGame)
            )
          ],
        );
      }
    );
  }


}

