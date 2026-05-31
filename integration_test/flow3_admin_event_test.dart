import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'helpers/integration_helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Flow 3: Admin Onboarding → Dashboard → Create Event', () {
    testWidgets('Register as admin, reach dashboard, open create event',
        (tester) async {
      await launchApp(tester);

      // Step 1: Splash → StarterScreen
      await waitForWidget(tester, find.text('Ready to Glint'),
          timeout: const Duration(seconds: 10));
      await pumpUntilSettled(tester);

      // Step 2: Tap "Create Admin Account"
      await tapByText(tester, 'Create Admin Account');
      await pumpUntilSettled(tester);

      // Step 3: Fill admin registration form
      await waitForWidget(tester, find.text('Create Account'),
          timeout: const Duration(seconds: 5));

      final random = Random().nextInt(99999);

      final nameField = find.widgetWithText(TextField, 'Enter Your Name');
      await waitForWidget(tester, nameField);
      await tester.enterText(nameField, 'AdminTest$random');
      await tester.pump();

      await tester.enterText(
          find.widgetWithText(TextField, 'Enter Email'),
          'admintest$random@glinttest.io');
      await tester.pump();

      await tester.enterText(
          find.widgetWithText(TextField, 'Organization (ex: Hotel Vistara)'),
          'Test Org $random');
      await tester.pump();

      await tester.enterText(
          find.widgetWithText(TextField, 'Contact Number'), '9876543210');
      await tester.pump();

      await tester.enterText(
          find.widgetWithText(TextField, 'Create Password'), 'TestPass12345!');
      await tester.pump();

      // Step 4: Tap Register
      await tapByText(tester, 'Register');
      await tester.pump();

      // Step 5: Wait for Admin Dashboard
      await waitForWidget(
        tester,
        find.textContaining('Hello'),
        timeout: const Duration(seconds: 30),
      );
      await pumpUntilSettled(tester);

      // Step 6: Verify dashboard elements
      expect(find.textContaining('Hello'), findsWidgets);
      expect(find.text('Create Event'), findsOneWidget);
      expect(find.text('Track Event'), findsOneWidget);
      expect(find.text('Recent Events'), findsOneWidget);

      // Step 7: Tap "Create Event"
      await tapByText(tester, 'Create Event');
      await pumpUntilSettled(tester);

      // Step 8: Verify Create Event screen loaded
      await waitForWidget(tester, find.text('Create Event'),
          timeout: const Duration(seconds: 10));

      // Step 9: Fill event name
      final eventNameField =
          find.widgetWithText(TextField, 'The Indian Food Festival');
      if (eventNameField.evaluate().isNotEmpty) {
        await tester.enterText(eventNameField, 'Integration Test Event');
        await tester.pump();
      }

      // Step 10: Select event type "Normal"
      final normalChip = find.text('Normal');
      if (normalChip.evaluate().isNotEmpty) {
        await tester.tap(normalChip.first);
        await tester.pump(const Duration(milliseconds: 300));
      }

      // Step 11: Select category "Meetup"
      final meetupChip = find.text('Meetup');
      if (meetupChip.evaluate().isNotEmpty) {
        await tester.tap(meetupChip.first);
        await tester.pump(const Duration(milliseconds: 300));
      }

      // Step 12: Navigate back to dashboard
      final backIcon = find.byIcon(Icons.arrow_back);
      if (backIcon.evaluate().isNotEmpty) {
        await tester.tap(backIcon.first);
        await pumpUntilSettled(tester);
      } else {
        final backButton = find.byType(BackButton);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton.first);
          await pumpUntilSettled(tester);
        }
      }

      // Step 13: Verify back on dashboard
      await waitForWidget(tester, find.text('Recent Events'),
          timeout: const Duration(seconds: 5));
      drainErrors(tester);
    });
  });
}
