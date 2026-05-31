import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:glint_frontend/main.dart' as app;

const Duration kNetworkTimeout = Duration(seconds: 15);
const Duration kAnimationTimeout = Duration(seconds: 5);
const Duration kShortWait = Duration(milliseconds: 500);

late FlutterExceptionHandler? _bindingErrorHandler;

Future<void> launchApp(WidgetTester tester) async {
  _bindingErrorHandler = FlutterError.onError;

  app.main();

  for (int i = 0; i < 30; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }

  // bootstrap.dart overrides FlutterError.onError (Crashlytics + analytics).
  // Restore the test binding's handler so zone errors are handled correctly.
  FlutterError.onError = _bindingErrorHandler;

  // Consume any errors that fired during bootstrap (Positioned misuse, etc.)
  tester.takeException();
}

/// Consume any pending exception from the test binding so that
/// app-level errors (S3 403s, DioExceptions, etc.) don't fail the test.
void drainErrors(WidgetTester tester) {
  while (tester.takeException() != null) {}
}

Future<bool> waitForHomeScreen(
  WidgetTester tester, {
  Duration timeout = const Duration(seconds: 30),
}) async {
  final swiperFinder = find.byKey(const ValueKey('people_card_swiper'));
  final emptyFinder = find.textContaining("a little quiet");

  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 250));
    drainErrors(tester);
    if (swiperFinder.evaluate().isNotEmpty) return true;
    if (emptyFinder.evaluate().isNotEmpty) return false;
  }
  final homeFinder = find.byType(Scaffold);
  expect(homeFinder, findsWidgets,
      reason: 'Home screen did not load within ${timeout.inSeconds}s');
  return false;
}

Future<void> waitForWidget(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = kNetworkTimeout,
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 250));
    drainErrors(tester);
    if (finder.evaluate().isNotEmpty) return;
  }
  expect(finder, findsWidgets,
      reason: 'Widget not found within ${timeout.inSeconds}s');
}

Future<void> waitForWidgetAbsent(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = kNetworkTimeout,
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 250));
    drainErrors(tester);
    if (finder.evaluate().isEmpty) return;
  }
  expect(finder, findsNothing,
      reason: 'Widget still present after ${timeout.inSeconds}s');
}

Future<void> pumpUntilSettled(
  WidgetTester tester, {
  Duration timeout = kNetworkTimeout,
}) async {
  try {
    await tester.pumpAndSettle(
      const Duration(milliseconds: 100),
      EnginePhase.sendSemanticsUpdate,
      timeout,
    );
  } on FlutterError {
    await tester.pump();
  }
  drainErrors(tester);
}

Future<void> enterTextInField(
  WidgetTester tester,
  String hintText,
  String value,
) async {
  final field = find.widgetWithText(TextField, hintText);
  if (field.evaluate().isEmpty) {
    final editableField = find.byWidgetPredicate((widget) {
      if (widget is EditableText) return true;
      if (widget is TextField && widget.decoration?.hintText == hintText) {
        return true;
      }
      return false;
    });
    await tester.tap(editableField.first);
  } else {
    await tester.tap(field.first);
  }
  await tester.pump();
  await tester.enterText(field.first, value);
  await tester.pump();
}

Future<void> tapByText(WidgetTester tester, String text) async {
  final finder = find.text(text);
  expect(finder, findsWidgets, reason: 'Expected to find text: "$text"');
  await tester.tap(finder.first);
  await tester.pump();
}

Future<void> tapByTextContaining(WidgetTester tester, String text) async {
  final finder = find.textContaining(text);
  expect(finder, findsWidgets,
      reason: 'Expected to find text containing: "$text"');
  await tester.tap(finder.first);
  await tester.pump();
}

Future<void> scrollUntilVisible(
  WidgetTester tester,
  Finder finder, {
  Finder? scrollable,
  double delta = -200.0,
  int maxScrolls = 20,
}) async {
  final scrollFinder = scrollable ?? find.byType(Scrollable).first;
  for (var i = 0; i < maxScrolls; i++) {
    if (finder.evaluate().isNotEmpty) return;
    await tester.drag(scrollFinder, Offset(0, delta));
    await tester.pump(const Duration(milliseconds: 300));
  }
}

/// Unfocuses any active text field so the system keyboard is dismissed,
/// then pumps a short settle window.
Future<void> dismissKeyboard(WidgetTester tester) async {
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pump(const Duration(milliseconds: 600));
  drainErrors(tester);
}

/// Dismisses the topmost modal bottom-sheet by tapping its [ModalBarrier].
/// Safe to call even when no sheet is open (becomes a no-op).
Future<void> dismissBottomSheet(WidgetTester tester) async {
  final barriers = find.byType(ModalBarrier);
  if (barriers.evaluate().isNotEmpty) {
    await tester.tap(barriers.last, warnIfMissed: false);
    await tester.pump(const Duration(milliseconds: 800));
    drainErrors(tester);
  }
}

/// Repeatedly taps [toTap] every [interval] until [toDisappear] leaves the
/// widget tree (navigation succeeded) or [maxAttempts] is exhausted.
///
/// Use this for buttons whose tap is a no-op until an async BLoC state
/// update arrives (e.g., SetupGlintOnboardingScreen's Next button which
/// guards behind `tempUserId == NEW_ON_BOARD_USER_ID`).
Future<void> tapUntilGone(
  WidgetTester tester, {
  required Finder toTap,
  required Finder toDisappear,
  int maxAttempts = 20,
  Duration interval = const Duration(milliseconds: 500),
}) async {
  for (var i = 0; i < maxAttempts; i++) {
    if (toDisappear.evaluate().isEmpty) return;
    drainErrors(tester);
    if (toTap.evaluate().isNotEmpty) {
      await tester.tap(toTap.first, warnIfMissed: false);
    }
    await tester.pump(interval);
  }
}
