// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:videochat_client/features/authentication/domain/entities/user.dart';
import 'package:videochat_client/features/users/presentation/widgets/user_profile.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final user = UserEntity(
      id: "123",
      username: "ivan_test",
      phoneNumber: null,
      email: "ivan@kuchmenko.com",
      image: null,
      firstName: "Ivan",
      lastName: "Kuchmenko",
      fullName: "Ivan Kuchmenko",
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Container(
            child: UserProfile(
              user: user,
            ),
          ),
        ),
      ),
    );

    expect(find.text(user.fullName), findsOneWidget);
    expect(find.text(user.getUsername()), findsOneWidget);
  });
}
