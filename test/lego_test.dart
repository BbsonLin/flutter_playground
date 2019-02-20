// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_playground/lego_things/main.dart';
import 'package:flutter_playground/pages/lego_things/app.dart';
import 'package:flutter_playground/main.dart';

void main() {
  testWidgets('Now time widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MainApp());

    await tester.tap(find.text('Lego Things'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Now Time'));
    await tester.pumpAndSettle();

    // Verify that NowTime is in page.
    print(find.byType(NowTime));
    expect(find.byType(NowTime), findsOneWidget);
  });
  testWidgets('PinPad widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MainApp());

    await tester.tap(find.text('Lego Things'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Pin pad'));
    await tester.pumpAndSettle();

    // Verify that PinPad is in page.
    expect(find.byType(PinPad), findsOneWidget);

//    await tester.tap(find.text("2"));
//    await tester.pumpAndSettle();
//    await tester.tap(find.text("5"));
//    await tester.pumpAndSettle();
//
//    expect(find.text("*"), findsNWidgets(2));
  });
  testWidgets('Counter widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MainApp());

    await tester.tap(find.text('Lego Things'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Counter'));
    await tester.pumpAndSettle();

    // Verify that Counter is in page.
    expect(find.byType(Counter), findsOneWidget);

    // Tap add twice and tap remove once
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();

    expect(find.text("1"), findsOneWidget);
  });
}
