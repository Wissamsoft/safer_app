# Changelog

## Unreleased (feature/pixel-perfect)

- Implemented Arabic/RTL pixel-perfect UI for Splash, Onboarding, Home, Map, Profile, Payments, and Details. ✅
- Added responsive sizing helper and made components adapt across screen sizes. ✅
- Accessibility improvements: added Semantics & Tooltips for interactive controls. ✅
- Fixed layout overflow in `TransportDetailScreen` by adding scrollability. ✅
- Persistent favorites using `SharedPreferences` and a dedicated `Favorites` helper. ✅
- Added widget tests: favorites toggle, navigation to details, responsive smoke test. ✅
- Updated theme tokens and improved visual polish (spacing, typography, Lottie sizing). ✅
- Added persisted tracking (follow) feature across Detail screens, Cards, and Favorites; implemented `Tracking` helper backed by `SharedPreferences`. ✅
- Added UI indicators for tracked items (animated), tooltips and snackbars for follow/unfollow actions. ✅
- Stabilized integration tests by adding test asset bundle fallbacks and window sizing adjustments; all tests now pass locally. ✅
- Ran `dart fix` and formatted code to remove deprecated APIs and clean imports. ✅
- Made "All Screens" page accessible from Settings so users can navigate to any page directly. ✅
- Added `CONTRIBUTING.md` with the pre-merge checklist and developer workflow. ✅

---

Please review visuals and accessibility (screen reader + RTL) before merge.
