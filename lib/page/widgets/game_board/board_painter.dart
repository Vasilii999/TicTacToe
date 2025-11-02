import 'package:endless_tic_tac_toe/constant/board_constants.dart';
import 'package:endless_tic_tac_toe/constant/symbol_xo.dart';
import 'package:flutter/material.dart';

class BoardPainter extends CustomPainter {
  final List<SymbolXO> board;
  final List<Color> symbolColors;

  BoardPainter({
    required this.board,
    required this.symbolColors,
  }) : assert(board.length == 9 && symbolColors.length == 9);

  @override
  void paint(Canvas canvas, Size size) {
    final paintGrid = Paint()
      ..color = BoardConstants.gridColor
      ..strokeWidth = BoardConstants.gridStroke
      ..strokeCap = StrokeCap.round;

    final cell = size.width / 3;

    // сетка
    for (int i = 1; i <= 2; i++) {
      final dx = cell * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paintGrid);
      final dy = cell * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paintGrid);
    }

    final paintSymbol = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = BoardConstants.symbolStroke;

    for (int i = 0; i < 9; i++) {
      final s = board[i];
      if (s == SymbolXO.empty) continue;

      final col = i % 3;
      final row = i ~/ 3;
      final left = col * cell;
      final top = row * cell;
      final right = (col + 1) * cell;
      final bottom = (row + 1) * cell;

      final padding = cell * BoardConstants.paddingFactor;
      final center = Offset(left + cell / 2, top + cell / 2);

      paintSymbol.color = symbolColors[i];

      if (s == SymbolXO.X) {
        canvas.drawLine(Offset(left + padding, top + padding),
            Offset(right - padding, bottom - padding), paintSymbol);
        canvas.drawLine(Offset(right - padding, top + padding),
            Offset(left + padding, bottom - padding), paintSymbol);
      } else {
        final radius = (cell / 2) - padding;
        canvas.drawCircle(center, radius, paintSymbol);
      }
    }
  }

  @override
  bool shouldRepaint(covariant BoardPainter oldDelegate) {
    return oldDelegate.board != board || oldDelegate.symbolColors != symbolColors;
  }
}