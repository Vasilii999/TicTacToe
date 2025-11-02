import 'dart:math';
import 'package:endless_tic_tac_toe/constant/symbolXO.dart';
import 'package:flutter/material.dart';
import 'board_painter.dart';

class GameBoard extends StatelessWidget {
  final List<SymbolXO> board;
  final Color Function(int index) getSymbolColor;
  final void Function(int index) onCellTap;
  final double? size;

  const GameBoard({
    super.key,
    required this.board,
    required this.getSymbolColor,
    required this.onCellTap,
    this.size,
  })  : assert(board.length == 9);

  int _getIndexFromTap(Offset position, double cellSize) {
    final col = (position.dx / cellSize).floor().clamp(0, 2);
    final row = (position.dy / cellSize).floor().clamp(0, 2);
    return row * 3 + col;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final double boardSize =
        size ?? min(media.width * 0.9, media.height * 0.65);
    final double cellSize = boardSize / 3;

    return Center(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (details) {
          final local = details.localPosition;
          if (local.dx < 0 ||
              local.dy < 0 ||
              local.dx > boardSize ||
              local.dy > boardSize) {
            return;
          }

          onCellTap(_getIndexFromTap(local, cellSize));
        },
        child: SizedBox(
          width: boardSize,
          height: boardSize,
          child: CustomPaint(
            size: Size(boardSize, boardSize),
            painter: BoardPainter(
              board: board,
              symbolColors: List.generate(9, (i) => getSymbolColor(i)),
            ),
          ),
        ),
      ),
    );
  }
}