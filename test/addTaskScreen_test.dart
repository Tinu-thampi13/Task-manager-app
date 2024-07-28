import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('homescreen page widget test', (tester) async {
    final text1 = find.text("Add Task");
    expect(text1, findsOneWidget);

    final text2 = find.text("Title");
    expect(text2, findsOneWidget);

    final text3 = find.text("Note");
    expect(text3, findsOneWidget);

    final text4 = find.text("Date");
    expect(text4, findsOneWidget);

    final text5 = find.text("Start Date");
    expect(text5, findsOneWidget);

    final text6 = find.text("End Date");
    expect(text6, findsOneWidget);

    final text7 = find.text("Remind");
    expect(text7, findsOneWidget);

    final text8 = find.text("Repeat");
    expect(text8, findsOneWidget);

    final text9 = find.text("Color");
    expect(text9, findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // final addTaskBtn = find.byType(GestureDetector);
    // await tester.tap(addTaskBtn);

    await tester.pump();
  });
}
