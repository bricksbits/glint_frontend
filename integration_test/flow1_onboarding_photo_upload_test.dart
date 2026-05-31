import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/features/onboarding/upload_photos_onboarding_screen.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path_provider/path_provider.dart';

import 'helpers/integration_helpers.dart';

/// ── Flow 1: Full Female Onboarding → Home Screen ──
///
/// Walks through the entire new-user onboarding flow end-to-end:
///
/// 1.  Splash → StarterScreen ("Ready to Glint")
/// 2.  Starter → SetupGlintOnboardingScreen — retry-tap Next until
///     OnBoardingCubit async init completes (tempUserId guard).
/// 3.  EnterNameOnboardingScreen — random first name, dismiss keyboard,
///     tap via ValueKey('name_next_button').
/// 4.  DateOfBirthOnboardingScreen — dismiss auto-opened BottomPicker via
///     ModalBarrier, use default date (18 years ago), confirm age.
/// 5.  IdentifyYourselfOnboardingScreen — select "I'm Female".
/// 6.  WhoCatchesYourEyeOnboardingScreen — select "Man".
/// 7.  UploadPhotosOnboardingScreen — bypass native image-picker:
///       • copy an app asset to the profileImages directory so
///         ImageService.loadSavedImages() finds it during registration;
///       • inject the File directly into OnBoardingCubit.emitNewState so
///         the UI shows the image as uploaded.
/// 8.  GetSetGlintOnboardingScreen (pronouns / looking-for) — "Long-Term".
/// 9.  InterestsAndVibeOnboardingScreen — select 5 chips (minimum required).
/// 10. OneLastStepOnboardingScreen (bio) — enter bio text, fill all six
///     AdditionalInfo rows (Occupation text, Education/Height/Workout/
///     Drinking/Smoking via bottom-sheets).
/// 11. LocationPermissionOnboardingScreen — tap "Proceed anyway >>" to skip
///     OS permission dialogs.
/// 12. CreateAccounScreen — register with a unique random email / password.
/// 13. Home screen — assert arrival (swiper key or empty-state text).
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Flow 1 – Full female onboarding to Home Screen', () {
    testWidgets(
      'Female user completes onboarding, registers, and lands on Home Screen',
      (tester) async {
        await launchApp(tester);

        // ── Milestone 1: Splash → StarterScreen ────────────────────────────
        await waitForWidget(
          tester,
          find.text('Ready to Glint'),
          timeout: const Duration(seconds: 15),
        );
        await pumpUntilSettled(tester);

        // ── Milestone 2: Create Account → SetupGlintOnboardingScreen ───────
        await tapByText(tester, 'Create Account');
        await pumpUntilSettled(tester);

        await waitForWidget(
          tester,
          find.textContaining('Setup your', findRichText: true),
          timeout: const Duration(seconds: 10),
        );

        // OnBoardingCubit.initializePersonWithAllDetails() is async.
        // Next is a no-op until state.currentState?.tempUserId == NEW_ON_BOARD_USER_ID.
        await tapUntilGone(
          tester,
          toTap: find.text('Next'),
          toDisappear: find.textContaining('Setup your', findRichText: true),
          maxAttempts: 20,
          interval: const Duration(milliseconds: 500),
        );
        await pumpUntilSettled(tester);

        // ── Milestone 3: Enter name ─────────────────────────────────────────
        await waitForWidget(
          tester,
          find.textContaining('First Name', findRichText: true),
          timeout: const Duration(seconds: 8),
        );

        final nameField = find.byType(TextField);
        await tester.tap(nameField.first);
        await tester.pump(const Duration(milliseconds: 300));

        final rnd = Random().nextInt(99999);
        await tester.enterText(nameField.first, 'GlintFemale$rnd');
        await tester.pump(const Duration(milliseconds: 300));

        await dismissKeyboard(tester);

        final nameNextBtn = find.byKey(const ValueKey('name_next_button'));
        await waitForWidget(tester, nameNextBtn,
            timeout: const Duration(seconds: 5));
        await tester.tap(nameNextBtn, warnIfMissed: false);
        await pumpUntilSettled(tester);

        // ── Milestone 4: Date of Birth → Age Confirmation ──────────────────
        await waitForWidget(
          tester,
          find.textContaining('Date of Birth', findRichText: true),
          timeout: const Duration(seconds: 8),
        );
        await tester.pump(const Duration(seconds: 1));

        // The screen auto-opens BottomPicker in addPostFrameCallback.
        // Dismiss its ModalBarrier so the DOB screen's Next button is free.
        await dismissBottomSheet(tester);

        // _selectedDate is already DateTime.now().year - 18 (always >= 18).
        await tapByText(tester, 'Next');
        await tester.pump(const Duration(milliseconds: 800));

        await waitForWidget(tester, find.text('Confirm Age'),
            timeout: const Duration(seconds: 5));
        await tapByText(tester, 'Confirm Age');
        await pumpUntilSettled(tester);

        // ── Milestone 5: Gender – Female ───────────────────────────────────
        await waitForWidget(tester, find.text('Identify Yourself?'),
            timeout: const Duration(seconds: 8));
        await tapByText(tester, "I'm Female");
        await tester.pump(const Duration(milliseconds: 300));
        await tapByText(tester, 'Next');
        await pumpUntilSettled(tester);

        // ── Milestone 6: Preference – Man ──────────────────────────────────
        await waitForWidget(tester, find.text('Who Catches'),
            timeout: const Duration(seconds: 8));
        await tapByText(tester, 'Man');
        await tester.pump(const Duration(milliseconds: 300));
        await tapByText(tester, 'Next');
        await pumpUntilSettled(tester);

        // ── Milestone 7: Photo Upload – inject fake image ───────────────────
        await waitForWidget(tester, find.text('First Impression!'),
            timeout: const Duration(seconds: 8));

        // Copy an existing app asset into the profileImages directory.
        // ImageService.loadSavedImages() reads picture_\d+.jpg files from
        // that directory during the registration upload step.
        final assetBytes = await rootBundle.load(
          'lib/assets/images/onboarding/stars_background_illustration.png',
        );
        final appDocDir = await getApplicationDocumentsDirectory();
        final profileDir = Directory('${appDocDir.path}/profileImages');
        if (!await profileDir.exists()) {
          await profileDir.create(recursive: true);
        }
        final fakeProfileImage = File('${profileDir.path}/picture_1.jpg');
        await fakeProfileImage.writeAsBytes(assetBytes.buffer.asUint8List());

        // Inject the File into the cubit so the UI counts "1 image uploaded"
        // and validateIfImageProvidedOrNot() returns true.
        final uploadCtx =
            tester.element(find.byType(UploadPhotosOnboardingScreen));
        final boardingCubit = BlocProvider.of<OnBoardingCubit>(uploadCtx);
        boardingCubit.emitNewState(boardingCubit.state
            .copyWith(uploadedFilePaths: [fakeProfileImage]));
        await tester.pump(const Duration(milliseconds: 300));

        await tapByText(tester, 'Next');
        await pumpUntilSettled(tester);

        // ── Milestone 8: GetSetGlint (looking-for / pronouns screen) ────────
        await waitForWidget(
          tester,
          find.textContaining('Set your vibe'),
          timeout: const Duration(seconds: 8),
        );
        await waitForWidget(tester, find.text("I'm Looking For"),
            timeout: const Duration(seconds: 5));
        await tapByText(tester, 'Long-Term');
        await tester.pump(const Duration(milliseconds: 300));
        await tapByText(tester, 'Next');
        await pumpUntilSettled(tester);

        // ── Milestone 9: Interests – select 5 chips ─────────────────────────
        await waitForWidget(tester, find.text('Your Interests, Your Vibe'),
            timeout: const Duration(seconds: 8));

        // First five in "Hobbies & Creativity" – all visible without scrolling.
        for (final label in const [
          'Drawing',
          'Photography',
          'Baking',
          'Cooking',
          'Writing',
        ]) {
          await tester.ensureVisible(find.text(label));
          await tester.pump(const Duration(milliseconds: 200));
          await tester.tap(find.text(label));
          await tester.pump(const Duration(milliseconds: 200));
          drainErrors(tester);
        }

        // The Next button is at the bottom – scroll to it then tap.
        await tester.ensureVisible(find.text('Next'));
        await tester.pump(const Duration(milliseconds: 300));
        await tapByText(tester, 'Next');
        await pumpUntilSettled(tester);

        // ── Milestone 10: Bio screen (One Last Step) ─────────────────────────
        await waitForWidget(
          tester,
          find.textContaining('One Last', findRichText: true),
          timeout: const Duration(seconds: 8),
        );

        // Bio text field (first TextField on the screen).
        // EnterYourBio debounces 500ms before calling cubit.setBio.
        final bioField = find.byType(TextField).first;
        await tester.tap(bioField);
        await tester.pump(const Duration(milliseconds: 300));
        await tester.enterText(
          bioField,
          'Love exploring new places and meeting interesting people!',
        );
        await tester.pump(const Duration(milliseconds: 700)); // cover debounce
        await dismissKeyboard(tester);

        // ── Occupation ── open sheet → type → tap arrow to submit ───────────
        await tester.ensureVisible(find.text('Occupation'));
        await tester.pump(const Duration(milliseconds: 300));
        await tester.tap(find.text('Occupation'));
        await tester.pump(const Duration(milliseconds: 400));
        final occField = find.byType(TextField).last;
        await tester.tap(occField);
        await tester.pump(const Duration(milliseconds: 300));
        await tester.enterText(occField, 'Software Engineer');
        await tester.pump(const Duration(milliseconds: 300));
        // Tap the arrow_forward icon suffix to submit + close the sheet.
        await tester.tap(find.byIcon(Icons.arrow_forward));
        await tester.pump(const Duration(milliseconds: 400));

        // ── Education ── CommonBottomSheetChipComponent auto-selects the
        //                 default in initState and calls onSelection.
        //                 Opening + closing is enough to set the value.
        await tester.ensureVisible(find.text('Education'));
        await tester.pump(const Duration(milliseconds: 300));
        await tester.tap(find.text('Education'));
        await tester.pump(const Duration(milliseconds: 400));
        await tapByText(tester, 'Done');
        await tester.pump(const Duration(milliseconds: 300));

        // ── Height ── drag slider to trigger onChanged, then close ──────────
        await tester.ensureVisible(find.text('Height'));
        await tester.pump(const Duration(milliseconds: 300));
        await tester.tap(find.text('Height'));
        await tester.pump(const Duration(milliseconds: 400));
        final slider = find.byType(Slider);
        if (slider.evaluate().isNotEmpty) {
          await tester.drag(slider.first, const Offset(20.0, 0.0));
          await tester.pump(const Duration(milliseconds: 300));
        }
        await tapByText(tester, 'Done');
        await tester.pump(const Duration(milliseconds: 300));

        // ── Workout / Drinking / Smoking ── same pattern as Education ────────
        for (final label in const ['Workout', 'Drinking', 'Smoking']) {
          await tester.ensureVisible(find.text(label));
          await tester.pump(const Duration(milliseconds: 300));
          await tester.tap(find.text(label));
          await tester.pump(const Duration(milliseconds: 400));
          await tapByText(tester, 'Done');
          await tester.pump(const Duration(milliseconds: 300));
          drainErrors(tester);
        }

        // Scroll to and tap the bio screen's Next button.
        await tester.ensureVisible(find.text('Next'));
        await tester.pump(const Duration(milliseconds: 300));
        await tapByText(tester, 'Next');
        await pumpUntilSettled(tester);

        // ── Milestone 11: Location – skip OS dialog ──────────────────────────
        await waitForWidget(
          tester,
          find.textContaining('Proceed anyway'),
          timeout: const Duration(seconds: 8),
        );
        await tapByTextContaining(tester, 'Proceed anyway');
        await pumpUntilSettled(tester);

        // ── Milestone 12: Registration ────────────────────────────────────────
        await waitForWidget(tester, find.text('Sign up'),
            timeout: const Duration(seconds: 8));

        final uniqueId = DateTime.now().millisecondsSinceEpoch % 999999;
        final testEmail = 'glinttest$uniqueId@testglint.com';
        // Password: 14+ chars, satisfies the ≥10-character rule.
        final testPassword =
            'GlintP@ss${uniqueId.toString().padLeft(6, '0')}';

        final emailField = find.byWidgetPredicate(
          (w) => w is TextField && w.decoration?.hintText == 'Enter Email',
        );
        final passwordField = find.byWidgetPredicate(
          (w) => w is TextField && w.decoration?.hintText == 'Create Password',
        );
        final confirmField = find.byWidgetPredicate(
          (w) =>
              w is TextField && w.decoration?.hintText == 'Confirm Password',
        );

        await tester.tap(emailField.first);
        await tester.pump(const Duration(milliseconds: 300));
        await tester.enterText(emailField.first, testEmail);
        await tester.pump(const Duration(milliseconds: 300));

        await tester.tap(passwordField.first);
        await tester.pump(const Duration(milliseconds: 300));
        await tester.enterText(passwordField.first, testPassword);
        await tester.pump(const Duration(milliseconds: 300));

        await tester.tap(confirmField.first);
        await tester.pump(const Duration(milliseconds: 300));
        await tester.enterText(confirmField.first, testPassword);
        await tester.pump(const Duration(milliseconds: 300));

        await dismissKeyboard(tester);
        await tapByText(tester, 'Sign up');
        await pumpUntilSettled(tester);

        // ── Milestone 13: Home Screen ─────────────────────────────────────────
        // Full async chain: create account → auto-login → upload image → home.
        await waitForHomeScreen(tester, timeout: const Duration(seconds: 30));

        drainErrors(tester);
      },
    );
  });
}
