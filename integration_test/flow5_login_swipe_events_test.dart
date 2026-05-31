import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'helpers/integration_helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Flow 5: Login → Swipe Profiles → Navigate to Events', () {
    testWidgets('Login, swipe cards, then switch to Events tab',
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
      final hasProfiles = await waitForHomeScreen(tester);

      if (hasProfiles) {
        final swiperFinder = find.byKey(const ValueKey('people_card_swiper'));

        // Step 6: Swipe LEFT (dislike)
        await tester.drag(swiperFinder, const Offset(-300, 0));
        await tester.pump(const Duration(seconds: 1));
        await pumpUntilSettled(tester, timeout: kAnimationTimeout);

        // Step 7: Swipe RIGHT (like)
        if (swiperFinder.evaluate().isNotEmpty) {
          await tester.drag(swiperFinder, const Offset(300, 0));
          await tester.pump(const Duration(seconds: 1));
          await pumpUntilSettled(tester, timeout: kAnimationTimeout);
        }

        // Step 8: Swipe LEFT again
        if (swiperFinder.evaluate().isNotEmpty) {
          await tester.drag(swiperFinder, const Offset(-300, 0));
          await tester.pump(const Duration(seconds: 1));
          await pumpUntilSettled(tester, timeout: kAnimationTimeout);
        }
      }

      // Step 9: Tap Event tab (2nd nav item)
      await tester.pump(const Duration(seconds: 1));
      drainErrors(tester);
      final allGestures = find.byType(GestureDetector);
      final gestureCount = allGestures.evaluate().length;
      if (gestureCount >= 4) {
        // Event tab is the 2nd from the left (index 1)
        // Bottom nav items are the last 4 GestureDetectors
        await tester.tap(allGestures.at(gestureCount - 3));
        await tester.pump(const Duration(seconds: 2));
      }

      // Step 10: Verify EventBaseScreen
      await waitForWidget(tester, find.text('Events'),
          timeout: const Duration(seconds: 10));
      expect(find.text('Events'), findsWidgets);

      // Step 11: Look for Explore tab
      final exploreFinder = find.text('Explore');
      if (exploreFinder.evaluate().isNotEmpty) {
        await tester.tap(exploreFinder.first);
        await tester.pump(const Duration(seconds: 1));
        await pumpUntilSettled(tester, timeout: kAnimationTimeout);
      }
      drainErrors(tester);
    });
  });
}
