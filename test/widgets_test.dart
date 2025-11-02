import 'package:endless_tic_tac_toe/page/application/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App has a title', (WidgetTester tester) async {
    await tester.pumpWidget(Application());

    expect(find.text('Endless Tic Tac Toe'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
  });
}