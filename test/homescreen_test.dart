import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_management_app/Screens/homescreen.dart';

void main() {
  testWidgets('homescreen page widget test', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));

    final text1 = find.text("Task Manager");
    expect(text1, findsOneWidget);

    final text2 = find.text("Today");
    expect(text2, findsOneWidget);

    final icon = find.byIcon(Icons.person);
    expect(icon, findsOneWidget);

    final Finder switchToInputIcon =
        find.byWidgetPredicate((Widget w) => w is IconButton);
    await tester.tap(switchToInputIcon);
    await tester.pumpAndSettle();

    var currentDt = DateTime.now();
    final EditableText input = tester.widget<EditableText>(
        find.textContaining(currentDt.year.toString()).first);

    input.controller.text = "29.07.2024";
    await tester.pumpAndSettle();

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // final addTaskBtn = find.byType(GestureDetector);
    // await tester.tap(addTaskBtn);

    await tester.pump();
  });
}
