---
name: Stream Chat SDK API quirks
description: Counterintuitive Stream Chat Flutter v9 Channel method signatures for reactions
type: feedback
---

`Channel.sendReaction` and `Channel.deleteReaction` have *mismatched* signatures in Stream Chat Flutter v9:

- `sendReaction(Message message, String type, {...})` — second arg is a plain **String** type
- `deleteReaction(Message message, Reaction reaction)` — second arg is a **Reaction** object

**Why:** Discovered during implementation — the SDK is inconsistent between the two methods.
**How to apply:** When calling either reaction method, check this note first to avoid the type error.
