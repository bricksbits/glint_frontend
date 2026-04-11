---
name: Chat Feature Implementation State
description: Status of chat feature tasks completed on branch claude/chat (Apr 2026)
type: project
---

Branch `claude/chat` — 7 tasks completed:

1. **Session guard** (`chat_service.dart`) — `connectUser()` skips reconnect if same user already connected.
2. **FCM push** — `registerDevice()` added to `ChatService`; called from `ChatRepoImpl.connectToServer()`; `flutter_local_notifications 18.0.1` added for foreground banners; `_setupFcmHandlers()` in `bootstrap.dart`.
3. **Message reactions** — `toggleReaction(Message, String)` in `ChatWithCubit`; long-press picker + reaction count row in `ChatWithScreen`. 5 emojis: 👍❤️😂😮😢.
4. **OneTimeImageView** — `InteractiveViewer`, `BoxFit.contain`, working `loadingBuilder`, `Expanded` for any image size.
5. **Header avatar** — `_HeaderAvatar` widget with `FadeInImage` + fallback; no crash on empty URL.
6. **Channel tile ValueKey** — `ValueKey(channel.id)` prevents `queryMembers()` re-firing on list refresh.
7. **Lifecycle reconnect** — `WidgetsBindingObserver` in `ChatScreenState`; `reconnectIfNeeded()` on resume. Also fixed `late final` bug in `ChatScreenCubit` controller fields.

**Why:** All for first-release stability — Stream SDK session consistency, push notifications, and polish.
**How to apply:** Stream Chat Notification tap-handling is deferred to a separate dedicated branch.
