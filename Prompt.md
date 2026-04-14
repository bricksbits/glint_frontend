# Task: Integrate PeopleCardsBloc with PeopleInterestedForEventScreen

## Context
- `PeopleScreen` already uses `PeopleCardsBloc` correctly
- `PeopleInterestedForEventScreen` has legacy code that needs to be refactored to use the same bloc pattern
- Both screens share similar UI/UX but have different data sources and behaviors

## Reference Implementation
Learn the pattern from: `PeopleScreen` (this is the source of truth for bloc integration)

## Requirements

### 1. Bloc Integration
- Refactor `PeopleInterestedForEventScreen` to use `PeopleCardsBloc`
- Support the `interestedPeople` case specifically
- Ensure the bloc can handle **two different screen contexts** without data collision

### 2. Data Fetching Differences
| Aspect     | PeopleScreen        | PeopleInterestedForEventScreen                             |
|------------|---------------------|------------------------------------------------------------|
| Caching    | Yes (offline-based) | **No caching** (always fresh)                              |
| Pagination | Offline-based       | **Online pagination** (increment offset on each fetch)     |
| API        | Existing people API | **Interested users API** (fetch users interested in event) |

### 3. Pagination
- Implement **offset-based pagination** for interested users
- Pass incrementing offset values to fetch new pages
- No local cache—always hit the API

### 4. Rewind Mechanism
- Support rewind functionality (same as PeopleScreen)
- AppBar has **only one action**: Rewind button

### 5. Screen Differentiation
- Create an **enum** (e.g., `PeopleScreenType { discover, interestedInEvent }`) to differentiate contexts
- Bloc should handle both types cleanly without mixing state/data
- Ensure no data leakage between screen types

### 6. UI Parity
- `PeopleInterestedForEventScreen` should be **almost identical** to `PeopleScreen`
- **Only difference**: Custom AppBar (single rewind action)

## Deliverables
1. **First**: Confirm your understanding of the requirements
2. **Second**: List any clarifying questions before implementation
3. **Then**: Propose your implementation plan (files to modify, new files if any)