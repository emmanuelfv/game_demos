import 'package:tic_tac_toe/checkers/domain/Piece_state.dart';

class CheckersGame {

  List<PieceState> grid;
  bool ohTurn;
  int playerXWins;
  int playerOWins;
  int taps;
  int? selectedPiece;

  CheckersGame({
    this.ohTurn = true,
    this.playerXWins = 0,
    this.playerOWins = 0,
    this.taps = 0,
  }) : grid = gridInitialState();

  static List<PieceState> gridInitialState(){
    List<PieceState> grid = List.filled(8*8, PieceState());

    for (int i=0; i<3; i++) {
      for (int j=0; j<4; j++) {
        grid[8*i + (i % 2) +  2*j] = PieceState(value: "x");
      }
    }

    for (int i=5; i<8; i++) {
      for (int j=0; j<4; j++) {
        grid[8*i + (i % 2) +  2*j] = PieceState(value: "o");
      }
    }

    return grid;
  } 

  String? tapped (int touchedPiece) {


    if (selectedPiece == null) {
      List<int> forcedMoves = checkForcedMoves();
      if(forcedMoves.isNotEmpty && !forcedMoves.contains(touchedPiece)) return null;

      String validSide = ohTurn ? "o" : "x";
      if(grid[touchedPiece].value != validSide) return null;
      selectedPiece = touchedPiece;
      return null;
    }

    if(_isValidMove(touchedPiece)) {
      _makeMove(touchedPiece);

      bool? ohIsWinner = _checkWinnter(grid);
      if(ohIsWinner==true) {
        playerOWins++;
        return _showWinDialog("O");
      }
      else  if(ohIsWinner==false) {
        playerXWins++;
        return _showWinDialog("X");
      }
      else if(taps == 8*8) {
        return _showDrawDialog();
      }
      return null;
    } else {
      selectedPiece = null;
      return null;
    } 
  }

  String _showWinDialog (String user)  {
    return "Winner is $user!";
  }

  String _showDrawDialog()  {
    return "End game, draw!";
  }

  void clearBoard() {
    selectedPiece = null;
    grid = gridInitialState();
    taps = 0;
  }

  bool? _checkWinnter (List<PieceState> grid) {
    //get for "o"
    if(_checkPlayerWon(grid, "o")) return true;
    if(_checkPlayerWon(grid, "x")) return false;
    return null;
  }

  bool _checkPlayerWon(List<PieceState> grid, String s) {
    for (int piece = 0; piece < 8*8; piece++) {
      if(!(grid[piece].value == s || grid[piece].value == "")) {
        return false;
      }
    }

    return true;
  }

  bool _isValidMove(int touchedPiece) {
    if(selectedPiece == null) return false;

    
    int selecteCol = selectedPiece! % 8;
    int selectedRow = (selectedPiece! / 8).floor();
    int touchedCol = touchedPiece % 8;
    int touchedRow = (touchedPiece / 8).floor();

    String validSide = ohTurn ? "o" : "x";
    if(grid[selectedPiece!].value != validSide) return false;

    int rowDiff = touchedRow - selectedRow;
    int colDiff = (touchedCol - selecteCol).abs();

    int expectedRowDiff = ohTurn ? -1 : 1;

    // king logic
    if(grid[selectedPiece!].isKing) {
      rowDiff = rowDiff.abs();
      expectedRowDiff = 1;
    }

    // Regular move
    if (grid[touchedPiece].value == "" && rowDiff == expectedRowDiff && colDiff == 1) {
      return true;
    }

    // Capture move
    if (grid[touchedPiece].value == "" && rowDiff == 2*expectedRowDiff && colDiff == 2) {
      int midRow = (selectedRow + touchedRow) ~/ 2;
      int midCol = (selecteCol + touchedCol) ~/ 2;
      int midIndex = midRow * 8 + midCol;

      String opponentSide = ohTurn ? "x" : "o";
      if (grid[midIndex].value == opponentSide) {
        grid[midIndex] = PieceState();
        return true;
      }
    }

    return false;
  }

  void _makeMove(int touchedPiece) {
    // Placeholder for any additional logic needed when making a move
    grid[touchedPiece] = grid[selectedPiece!];
    grid[selectedPiece!] = PieceState();

    // check for piece taken
    int touchedCol = touchedPiece % 8;
    int selectedCol = selectedPiece! % 8;
    if ((touchedCol - selectedCol).abs() == 2) {
      int midRow = ((touchedPiece / 8).floor() + (selectedPiece! / 8).floor()) ~/ 2;
      int midCol = (touchedCol + selectedCol) ~/ 2;
      int midIndex = midRow * 8 + midCol;
      grid[midIndex] = PieceState();
      if(checkForcedMoves(piece: touchedPiece).isEmpty) {
        selectedPiece = null;
        ohTurn = !ohTurn;
      }
    } else {
      selectedPiece = null;
      ohTurn = !ohTurn;
    }
    taps++;
  }

  List<int> checkForcedMoves({int? piece}) {
    if(piece != null) return checkForcedMovesForPiece(piece);

    List<int> forcedMoves = [];
    for (int index = 0; index < grid.length; index++) {
      forcedMoves.addAll(checkForcedMovesForPiece(index));
    }
    return forcedMoves;
  }

  List<int> checkForcedMovesForPiece(int index) {
    String validSide = ohTurn ? "o" : "x";
    String opponentSide = ohTurn ? "x" : "o";
    if (grid[index].value == validSide) {
      int row = (index / 8).floor();
      int col = index % 8;
    
      // Check all four diagonal directions for possible captures based on the piece color
      List<List<int>> directions = ohTurn
        ? [ [-2, -2], [-2, 2] ] : [ [2, -2], [2, 2] ];
      
      if(grid[index].isKing) directions = [ [-2, -2], [-2, 2], [2, -2], [2, 2] ];
    
      for (var direction in directions) {
        int newRow = row + direction[0];
        int newCol = col + direction[1];
        int midRow = row + direction[0] ~/ 2;
        int midCol = col + direction[1] ~/ 2;
    
        if (newRow >= 0 && newRow < 8 && newCol >= 0 && newCol < 8) {
          int newIndex = newRow * 8 + newCol;
          int midIndex = midRow * 8 + midCol;
    
          if (grid[newIndex].value == "" && grid[midIndex].value == opponentSide) {
            return [index];
          }
        }
      }
    }
    return [];
  }

  /*
    TODO: ADD draw conditions, no moves available and stalemate 
    TODO: UI improvements
    TODO: agent opponent
    TODO: show interface highlight for selected piece
    
  */

}