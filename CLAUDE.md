# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Flutter Version

This project uses **Flutter 3.32.5** via FVM. Prefix all Flutter commands with `fvm`:

```bash
fvm flutter pub get
fvm flutter run
fvm flutter analyze
fvm flutter format lib/
```

## Common Commands

```bash
# Install dependencies
./scripts/pub_get.sh

# Run app (staging by default)
fvm flutter run --dart-define=ENVIRONMENT=staging

# Regenerate code (Floor DB, Freezed, Injectable) — required after modifying annotated classes
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Build scripts
./scripts/android_debug.sh
./scripts/android_release.sh
./scripts/android_bundle.sh prod      # or staging
./scripts/ios_debug.sh
./scripts/ios_release.sh
./scripts/clean.sh                     # Clean build artifacts
```

## Architecture

**Clean Architecture** with strict layer separation: `features/` (presentation) → `domain/` (business logic) → `data/` (repositories, APIs, DB).

### Layers

- **`lib/features/`** — UI screens and BLoC/Cubit state management, organized by feature (auth, chat, people, event, profile, onboarding, admin, payment, etc.)
- **`lib/domain/`** — Repository interfaces (`business_logic/repo/`) and use cases (`application_logic/`). Use cases extend `CleanArchUseCase` base class and return `Result<T>` (Success/Failure sealed type from `utils/result_sealed.dart`).
- **`lib/data/`** — Repository implementations, `MyDioClient` (Dio HTTP client), Floor SQLite database, and encrypted SharedPreferences.
- **`lib/di/`** — GetIt + Injectable dependency injection. `injection.config.dart` is auto-generated — never edit manually.
- **`lib/navigation/`** — GoRouter configuration. Routes defined in `glint_all_routes.dart`, router config in `glint_main_route_config.dart`.
- **`lib/design/`** — Design system: theme, colors (`app_colours.dart`), typography, and reusable components.
- **`lib/services/`** — App-level services (StreamChat, image management, swipe cache, permissions).

### State Management

BLoC/Cubit with Freezed-generated sealed classes for states/events. Global BLoCs (`InternetStatusCheckerCubit`, `UserInfoManagerCubit`, `PaymentCubit`) are registered in `bootstrap.dart`. Feature BLoCs are scoped to their routes.

### Dependency Injection

GetIt service locator with Injectable for code generation. After modifying any `@injectable`, `@singleton`, or `@lazySingleton` annotated class, run `build_runner` to regenerate `injection.config.dart`. Access services via `getIt.get<T>()`.

### Database

Floor ORM (SQLite). Entities in `lib/data/local/db/entities/`, DAOs in `lib/data/local/db/dao/`. After modifying entities or DAOs, run `build_runner` and increment the database version in `GlintDatabase`.

### Environment Configuration

Staging/prod config loaded from `.env.staging` / `.env.prod` via `flutter_dotenv`. Selected at build time with `--dart-define=ENVIRONMENT=staging|prod`. Access via `AppConfig` in `lib/utils/app_config.dart`.

## Key Integrations

- **Stream Chat** — Real-time messaging, stories, and video calls via `StreamChatClient` (configured in `NetworkModule`)
- **Firebase** — Crashlytics (prod only), Analytics (`GlintAnalyticsService`), FCM push notifications
- **Razorpay** — Payment processing via `PaymentCubit`
- **Floor + Encrypted SharedPreferences** — Local persistence for profiles, swipe actions, event likes

## Code Generation

Three annotation processors require `build_runner`:
1. **Freezed** — Sealed state/event classes (`.freezed.dart` files)
2. **Floor** — Database DAOs and database builder (`.g.dart` files in `data/local/db/`)
3. **Injectable** — DI configuration (`di/injection.config.dart`)

Always run `build_runner` after modifying annotated classes.

## Rules 
- Don't generate or add summary .md files,for any features until asked 
- Create specific files and Follow the DRY principle 
- Follow the SOLID Principles 
- Don't add Documentation over the code, until explicitly said so,
- Feel free to ask me clarity questions, if felt stuck and confused or needed more context with clarity 
- 



















