
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ordonio_calculator/main.dart';

void main() {
  testWidgets('Calculator Addition Test',
      (WidgetTester tester) async {

    await tester.pumpWidget(const CalculatorApp());

    expect(find.text('My Stateful Calculator'), findsOneWidget);

    // Enter numbers
    await tester.enterText(find.byType(TextField).at(0), '20');
    await tester.enterText(find.byType(TextField).at(1), '5');

    // Click addition
    await tester.tap(find.widgetWithText(ElevatedButton, '+'));
    await tester.pump();

    // Verify result
    expect(find.text('25.0'), findsOneWidget);
  });

  testWidgets('Division by Zero Test',
      (WidgetTester tester) async {

    await tester.pumpWidget(const CalculatorApp());

    await tester.enterText(find.byType(TextField).at(0), '20');
    await tester.enterText(find.byType(TextField).at(1), '0');

    await tester.tap(find.widgetWithText(ElevatedButton, '÷'));
    await tester.pump();

    expect(find.text('Cannot divide by zero'), findsOneWidget);
  });

  testWidgets('Clear Calculator Test',
      (WidgetTester tester) async {

    await tester.pumpWidget(const CalculatorApp());

    await tester.enterText(find.byType(TextField).at(0), '20');
    await tester.enterText(find.byType(TextField).at(1), '5');

    await tester.tap(find.widgetWithText(ElevatedButton, '+'));
    await tester.pump();

    await tester.tap(find.text('Clear'));
    await tester.pump();

    expect(find.text('0'), findsOneWidget);
    expect(find.text('Enter two numbers'), findsOneWidget);
  });
}