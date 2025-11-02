import 'package:endless_tic_tac_toe/page/application/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Board shows grid and responds to taps', (WidgetTester tester) async {
    // Запускаем приложение
    await tester.pumpWidget(Application());

    // Проверяем, что заголовок есть
    expect(find.text('Endless Tic Tac Toe'), findsOneWidget);

    // Проверяем, что GridView присутствует
    expect(find.byType(GridView), findsOneWidget);

    // Проверяем кликабельность первой клетки
    final cell0 = find.byKey(const Key('cell_0'));
    await tester.tap(cell0);
    await tester.pump();

    // После клика должна появиться X
    expect(find.text('X'), findsOneWidget);
  });
}