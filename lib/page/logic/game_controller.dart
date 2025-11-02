import '../../constant/symbolXO.dart';
import '../models/move.dart';

class GameController {
  // доска
  List<SymbolXO> board = List.filled(9, SymbolXO.empty);

  // текущий ход
  SymbolXO currentTurn = SymbolXO.X;

  // счёт
  int teamBlueScore = 0;
  int teamRedScore = 0;

  // список ходов (для подсветки старых клеток)
  List<Move> xMoves = [];
  List<Move> oMoves = [];

  bool makeMove(int index) {
    // 1. Проверяем, свободна ли ячейка.
    if (board[index] != SymbolXO.empty) {
      return false;
    }

    // 2. Увеличиваем возраст всех существующих ходов на 1.
    // Это делает ходы "старше" с каждым новым ходом.
    for (var move in xMoves) {
      move.age++;
    }
    for (var move in oMoves) {
      move.age++;
    }

    // 3. Удаляем старые ходы, чей возраст достиг 2.
    // Ход с возрастом 2 — это тот, который "тускнеет" и должен исчезнуть.
    if (xMoves.isNotEmpty && xMoves.first.age >= 6) {
      final oldestMove = xMoves.removeAt(0);
      board[oldestMove.index] = SymbolXO.empty;
    }
    if (oMoves.isNotEmpty && oMoves.first.age >= 6) {
      final oldestMove = oMoves.removeAt(0);
      board[oldestMove.index] = SymbolXO.empty;
    }

    // 4. Ставим новый ход на доску.
    board[index] = currentTurn;
    final newMove = Move(index: index, age: 0);

    // 5. Добавляем новый, "яркий" ход в соответствующий список.
    if (currentTurn == SymbolXO.X) {
      xMoves.add(newMove);
    } else {
      oMoves.add(newMove);
    }

    // 6. Переключаем ход.
    currentTurn = (currentTurn == SymbolXO.X) ? SymbolXO.O : SymbolXO.X;

    return true;
  }

  void checkWinner() {
    const winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      final a = pattern[0];
      final b = pattern[1];
      final c = pattern[2];

      if (board[a] != SymbolXO.empty &&
          board[a] == board[b] &&
          board[b] == board[c]) {
        // победитель
        if (board[a] == SymbolXO.X) {
          teamBlueScore++;
        } else {
          teamRedScore++;
        }

        // сброс доски
        board = List.filled(9, SymbolXO.empty);
        xMoves.clear();
        oMoves.clear();
        return;
      }
    }

    // ничья
    if (!board.contains(SymbolXO.empty)) {
      board = List.filled(9, SymbolXO.empty);
      xMoves.clear();
      oMoves.clear();
    }
  }
}


