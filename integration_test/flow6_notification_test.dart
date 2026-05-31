import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'helpers/integration_helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Flow 6: Login → Notification Screen → Verify UI', () {
    testWidgets('Login and navigate to notification screen', (tester) async {
      await launchApp(tester);

      // Step 1: Splash → StarterScreen
      await waitForWidget(tester, find.text('Ready to Glint'),
          timeout: const Duration(seconds: 10));
      await pumpUntilSettled(tester);

      // Step 2: Tap Login
      await tapByText(tester, 'Login');
      await pumpUntilSettled(tester);

      // Step 3: Enter Flash credentials
      await tester.enterText(
          find.widgetWithText(TextField, 'Enter Email'), 'flash@glintapp.io');
      await tester.pump();
      await tester.enterText(
          find.widgetWithText(TextField, 'Enter Password'), '1234567890');
      await tester.pump();

      // Step 4: Tap Login
      await tapByText(tester, 'Login');
      await tester.pump();

      // Step 5: Wait for HomeScreen
      await waitForHomeScreen(tester);
      await tester.pump(const Duration(seconds: 2));
      drainErrors(tester);

      // Step 6: Tap the notification bell icon in the app bar
      // AppBar actions order: rollback(0), heart(1), bell(2), filter(3)
      final appBarGestures = find.descendant(
        of: find.byType(AppBar),
        matching: find.byType(GestureDetector),
      );

      if (appBarGestures.evaluate().length >= 3) {
        await tester.tap(appBarGestures.at(2));
        await tester.pump(const Duration(seconds: 2));
        drainErrors(tester);
      }

      // Step 7: Verify NotificationScreen loaded
      await waitForWidget(tester, find.text('Notifications'),
          timeout: const Duration(seconds: 10));
      expect(find.text('Notifications'), findsWidgets);

      // Step 8: Check notification content state
      await tester.pump(const Duration(seconds: 2));
      drainErrors(tester);
      await pumpUntilSettled(tester);

      final hasNotifications =
          find.textContaining('ago').evaluate().isNotEmpty;
      final hasEmptyState =
          find.text('No updates yet').evaluate().isNotEmpty;
      final hasError =
          find.text('Retry').evaluate().isNotEmpty;
      final hasBanner =
          find.text('Want More Matches?').evaluate().isNotEmpty;

      expect(hasNotifications || hasEmptyState || hasError || hasBanner, isTrue,
          reason: 'Should show notifications, empty state, or error state');

      // Drain any remaining errors before test cleanup
      drainErrors(tester);
    });
  });
}
