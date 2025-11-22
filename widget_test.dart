// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:copilot_chat/main.dart';

void main() {
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('ChatPage smoke test', (WidgetTester tester) async {
    // Build ChatPage directly to bypass SplashScreen
    await tester.pumpWidget(
      MaterialApp(
        home: const ChatPage(),
        theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      ),
    );
    await tester.pumpAndSettle();

    // Verify that our app bar title is present.
    expect(find.text('Copilot Chat'), findsOneWidget);

    // Verify that the initial assistant message is present.
    expect(
      find.text('Hi! I’m your AI copilot. Ask me anything or share an image.'),
      findsOneWidget,
    );
  });
}
