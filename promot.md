Here's a structured version of your prompt optimized for Sonnet:

---

# Task: Configure Flutter App for Apple App Store Release

## Context
- Flutter app targeting iOS for App Store distribution
- Apple Developer Account is **pending approval** (not yet active)
- Need to prepare everything now so it's ready to build & submit once the account is approved

---

## App Permissions Required
The app uses the following native iOS capabilities that need proper configuration:

| Permission | Usage |
|------------|-------|
| **Push Notifications** | Alert users of new messages / updates |
| **Location** | Read user's current location (specify: always / when in use) |

---

## Goal
Produce a **release build** ready for App Store submission,
with all entitlements, permissions, and signing configured correctly.

---

## What I Need Done

1. **`Info.plist` setup** — Add all required `NSUsageDescription` keys for each permission
2. **`Entitlements` file** — Configure push notifications and any other required entitlements
3. **`Podfile` / iOS target settings** — Ensure deployment target and capabilities are correct
4. **`Xcode project config`** — Signing, bundle ID, capabilities (even if signing is placeholder until account is ready)
5. **`build.gradle` / `pubspec.yaml` audit** *(if anything iOS-specific is declared there)*
6. **Release build command** — Provide the correct `flutter build ipa` command with flags

---

## Constraints & Notes
- ✅ Do make all config changes that don't require an active Apple account
- ⏸ Flag clearly anything that **requires the Apple account to be active** (e.g. provisioning profiles, certificates, App Store Connect setup)
- Do **not** change any Dart/Flutter business logic
- Keep changes minimal and production-safe

---

## Deliverable
A checklist of what's done, what's pending (needs Apple account), and the exact steps to complete submission once the account is approved.

---

**Tip for Sonnet:** Read `ios/Runner/Info.plist`, `ios/Runner/Runner.entitlements`, `ios/Podfile`, and `ios/Runner.xcodeproj/project.pbxproj` before making any changes.
**Tip for Sonnet:** Read `AndroidManifest` & `Gradle Files`, from Android Directory to have a better context.

