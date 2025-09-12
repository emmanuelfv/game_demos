class TicTacToeGame {

  List<String> grid = ["","","","","","","","",""];
  bool ohTurn = true;
  int playerXWins = 0;
  int playerOWins = 0;
  int taps = 0;

  TicTacToeGame({
    this.ohTurn = true,
    this.playerXWins = 0,
    this.playerOWins = 0,
    this.taps = 0,
  }) : grid = List<String>.filled(9, '');

  String? tapped (int index) {
    if(grid[index] != "") return null;

    grid[index] = ohTurn ? "o" : "x";
    ohTurn = !ohTurn;
    
    bool? ohIsWinner = _checkWinnter(grid);
    if(ohIsWinner==true) {
      playerOWins++;
      return _showWinDialog("O");
    }
    else  if(ohIsWinner==false) {
      playerXWins++;
      return _showWinDialog("X");
    }
    else if(++taps == 9) {
      return _showDrawDialog();
    }
    return null;
  }

  String _showWinDialog (String user)  {
    return "Winner is $user!";
  }

  String _showDrawDialog()  {
    return "End game, draw!";
  }

  void clearBoard() {
    grid = List<String>.filled(9, '');
    taps = 0;
  }

  bool? _checkWinnter (List<String> grid) {
    //get for "o"
    if(_checkPlayerWon(grid, "o")) return true;
    if(_checkPlayerWon(grid, "x")) return false;
    return null;
  }

  bool _checkPlayerWon(List<String> grid, String s) {
    if(grid[0] == s && grid[1] == s && grid[2] == s) return true;
    if(grid[3] == s && grid[4] == s && grid[5] == s) return true;
    if(grid[6] == s && grid[7] == s && grid[8] == s) return true;

    if(grid[0] == s && grid[3] == s && grid[6] == s) return true;
    if(grid[1] == s && grid[4] == s && grid[7] == s) return true;
    if(grid[2] == s && grid[5] == s && grid[8] == s) return true;

    if(grid[0] == s && grid[4] == s && grid[8] == s) return true;
    if(grid[2] == s && grid[4] == s && grid[6] == s) return true;
    return false;
  }

}