import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:endless_tic_tac_toe/page/application/application.dart';
import 'package:endless_tic_tac_toe/page/widgets/score_board.dart';

void main() {
  testWidgets('HomePage displays AppBar and ScoreBoard', (WidgetTester tester) async {
    // Запускаем приложение
    await tester.pumpWidget(const Application());
    await tester.pumpAndSettle();

    // Проверяем, что AppBar присутствует
    expect(find.byType(AppBar), findsOneWidget);

    // Проверяем, что ScoreBoard присутствует
    expect(find.byType(ScoreBoard), findsOneWidget);

    // Можно проверить, что Scaffold присутствует
    expect(find.byType(Scaffold), findsOneWidget);
  });
}