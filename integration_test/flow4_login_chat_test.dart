import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'helpers/integration_helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Flow 4: Login → Profiles Loaded → Chat', () {
    testWidgets('Login as Flash, reach home, navigate to chat',
        (tester) async {
      await launchApp(tester);

      // Step 1: Splash → StarterScreen
      await waitForWidget(tester, find.text('Ready to Glint'),
          timeout: const Duration(seconds: 10));
      await pumpUntilSettled(tester);

      // Step 2: Tap Login
      await tapByText(tester, 'Login');
      await pumpUntilSettled(tester);

      // Step 3: Enter Flash credentials
      final emailField = find.widgetWithText(TextField, 'Enter Email');
      await waitForWidget(tester, emailField);
      await tester.enterText(emailField, 'flash@glintapp.io');
      await tester.pump();
      await tester.enterText(
          find.widgetWithText(TextField, 'Enter Password'), '1234567890');
      await tester.pump();

      // Step 4: Tap Login
      await tapByText(tester, 'Login');
      await tester.pump();

      // Step 5: Wait for HomeScreen (swiper or empty state)
      await waitForHomeScreen(tester);

      // Step 6: Tap Chat tab (4th nav item in the bottom nav bar)
      await tester.pump(const Duration(seconds: 2));
      drainErrors(tester);

      // Find the bottom nav bar container (height 70, inside Scaffold)
      final allGestures = find.byType(GestureDetector);
      final gestureWidgets = allGestures.evaluate().toList();

      // The bottom nav GestureDetectors wrap Container > SvgPicture
      // They should be the last 4 GestureDetectors on screen
      if (gestureWidgets.length >= 4) {
        // Tap the last GestureDetector (Chat = index 3, rightmost nav item)
        await tester.tap(allGestures.at(gestureWidgets.length - 1));
        await tester.pump(const Duration(seconds: 2));
      }

      // Step 7: Verify ChatScreen
      await waitForWidget(tester, find.text('Chats'),
          timeout: const Duration(seconds: 15));
      expect(find.text('Chats'), findsWidgets);
      drainErrors(tester);
    });
  });
}
