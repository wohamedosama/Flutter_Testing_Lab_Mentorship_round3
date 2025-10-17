import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/weather_display.dart';

void main() {
  group('WeatherDisplay Tests', () {
    testWidgets('should display weather data correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );
      await tester.pumpAndSettle();

      // Should display weather information
      expect(find.text('New York'), findsWidgets);
      expect(find.text('Sunny'), findsOneWidget);
      expect(find.text('22.5°C'), findsOneWidget);
    });

    testWidgets('should convert temperature units correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );
      await tester.pumpAndSettle();

      // Switch to Fahrenheit
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      // Should show Fahrenheit (22.5°C = 72.5°F)
      expect(find.text('72.5°F'), findsOneWidget);
      expect(find.text('Fahrenheit'), findsOneWidget);
    });

    testWidgets('should handle city selection', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );
      await tester.pumpAndSettle();

      // Select London
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('London'));
      await tester.pumpAndSettle();

      // Should show London weather
      expect(find.text('London'), findsWidgets);
      expect(find.text('Rainy'), findsOneWidget);
      expect(find.text('15.0°C'), findsOneWidget);
    });

    testWidgets('should show error for invalid city', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );
      await tester.pumpAndSettle();

      // Select invalid city
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Invalid City'));
      await tester.pumpAndSettle();

      // Should show error
      expect(find.text('Error Loading Weather'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('should show loading state', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );
      await tester.pump();

      // Should show loading initially
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      // Loading should be gone
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
