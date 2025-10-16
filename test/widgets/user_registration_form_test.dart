import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/user_registration_form.dart';

void main() {
  testWidgets('User registration form should display all form fields', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: UserRegistrationForm())),
    );

    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
  });

  testWidgets('Form shows validation errors for invalid email', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: UserRegistrationForm())),
    );

    await tester.enterText(find.byType(TextFormField).at(1), 'invalid-email');

    await tester.tap(find.text('Register'));
    await tester.pump();

    expect(find.text('Please enter a valid email'), findsOneWidget);
  });

  testWidgets('Form shows validation errors for weak password ', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: UserRegistrationForm())),
    );
    await tester.enterText(find.byType(TextFormField).at(2), 'Weak');
    await tester.tap(find.text('Register'));
    await tester.pump();
    expect(
      find.text(
        'Password must be at least 8 characters with uppercase, lowercase, numbers and symbols',
      ),
      findsOneWidget,
    );
  });

  testWidgets('Form submits successfully with valid data', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: UserRegistrationForm())),
    );
    await tester.enterText(find.byType(TextFormField).at(0), 'Mohamed Osama');
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'mohamed@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(2), 'Strong@123');
    await tester.enterText(find.byType(TextFormField).at(3), 'Strong@123');
    await tester.tap(find.text('Register'));
    await tester.pump();

    // Wait for the 2-second delay to complete
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Check for either success or failure message (since it's random)
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            (widget.data == 'Registration successful!' ||
                widget.data == 'Registration failed!'),
      ),
      findsOneWidget,
    );
  });
}
