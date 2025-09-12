class Connect4Game {

  List<String> grid;
  List<int> upperBounds;
  bool ohTurn;
  int playerXWins;
  int playerOWins;
  int taps;

  Connect4Game({
    this.ohTurn = true,
    this.playerXWins = 0,
    this.playerOWins = 0,
    this.taps = 0,
  }) : grid = List<String>.filled(7*6, ''),
       upperBounds = List<int>.filled(7, 5);

  String? tapped (int index) {

    int col = index % 7;

    if(upperBounds[col] == 6) return null;

    grid[7*upperBounds[col] + col] = ohTurn ? "o" : "x";
    upperBounds[col]--;
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
    else if(++taps == 7*6) {
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
    grid = List<String>.filled(7*6, '');
    upperBounds = List<int>.filled(7, 5 );
    taps = 0;
  }

  bool? _checkWinnter (List<String> grid) {
    //get for "o"
    if(_checkPlayerWon(grid, "o")) return true;
    if(_checkPlayerWon(grid, "x")) return false;
    return null;
  }

  bool _checkPlayerWon(List<String> grid, String s) {
    // Check horizontal
    for (int row = 0; row < 6; row++) {
      for (int col = 0; col < 4; col++) {
        if (grid[row * 7 + col] == s &&
            grid[row * 7 + col + 1] == s &&
            grid[row * 7 + col + 2] == s &&
            grid[row * 7 + col + 3] == s) {
          return true;
        }
      }
    }

    // Check vertical
    for (int col = 0; col < 7; col++) {
      for (int row = 0; row < 3; row++) {
        if (grid[row * 7 + col] == s &&
            grid[(row + 1) * 7 + col] == s &&
            grid[(row + 2) * 7 + col] == s &&
            grid[(row + 3) * 7 + col] == s) {
          return true;
        }
      }
    }

    // Check diagonal
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 4; col++) {
        if (grid[row * 7 + col] == s &&
            grid[(row + 1) * 7 + col + 1] == s &&
            grid[(row + 2) * 7 + col + 2] == s &&
            grid[(row + 3) * 7 + col + 3] == s) {
          return true;
        }
      }
    }
    for (int row = 3; row < 6; row++) {
      for (int col = 0; col < 4; col++) {
        if (grid[row * 7 + col] == s &&
            grid[(row - 1) * 7 + col + 1] == s &&
            grid[(row - 2) * 7 + col + 2] == s &&
            grid[(row - 3) * 7 + col + 3] == s) {
          return true;
        }
      }
    }

    return false;
  }

}