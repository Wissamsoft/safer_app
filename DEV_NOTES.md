# Developer Notes

- Tests: run `flutter test` to execute unit and widget tests. The integration widget tests may set a test window size and provide a `DefaultAssetBundle` with a test asset bundle to avoid asset manifest decoding errors in the test environment.

- If an image resolution error occurs in tests (FormatException / no binary manifest), it's handled by the tests using a `_TestAssetBundle` which returns a minimal encoded manifest and a small base64 PNG for `Image.asset` widgets.

- `AllScreens` is available via `/all_screens` route and is now reachable from **Settings → عرض كل الشاشات** for easier QA and navigation.

- Local debugging: use `SharedPreferences.setMockInitialValues` in tests to set initial persisted state.

- Style & static fixes: run `dart fix --apply` and `dart format .` before pushing to keep the codebase clean.

- Key files to review when changing tracking/favorites/transport UI:

  - `lib/core/tracking.dart` (persistent tracking API)
  - `lib/core/favorites_safe.dart` (persistent favorites API)
  - `lib/widgets/transport_card.dart` (card UI + tracking indicator)
  - `lib/screens/transport_detail_screen.dart` and `lib/screens/trip_detail_screen.dart` (detail screens & tracking toggle)
  - `test/navigation_tracking_integration_test.dart` (integration test that validates navigation -> toggle -> return -> card refresh)

If you want, I can add a small CONTRIBUTING.md with required pre-merge checklist (tests passing, dart fix applied, changelog updated).
