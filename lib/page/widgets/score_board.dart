import 'package:endless_tic_tac_toe/constant/board_constants.dart';
import 'package:endless_tic_tac_toe/constant/symbol_xo.dart';
import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final int teamBlue;
  final int teamRed;
  final SymbolXO currentTurn;

  const ScoreBoard({
    super.key,
    required this.teamBlue,
    required this.teamRed,
    required this.currentTurn,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('$teamBlue',
            style: const TextStyle(fontSize: 50, color: BoardConstants.xColor)),
        Text(
          currentTurn == SymbolXO.X ? 'X' : 'O',
          style: TextStyle(
            fontSize: 60,
            color: currentTurn == SymbolXO.X
                ? BoardConstants.xColor
                : BoardConstants.oColor,
          ),
        ),
        Text('$teamRed',
            style: const TextStyle(fontSize: 50, color: BoardConstants.oColor)),
      ],
    );
  }
}
