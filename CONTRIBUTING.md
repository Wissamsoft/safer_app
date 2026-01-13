# CONTRIBUTING

Thank you for contributing to Safer App. This document describes the developer workflow, coding standards, and pre-merge checklist to keep the codebase clean and stable.

## Getting started

- Run `flutter pub get`.
- Use a consistent Flutter SDK (recommended: stable channel) and the Dart version specified in `pubspec.yaml`.

## Coding standards

- Run `dart format .` before committing.
- Run `dart fix --apply` to apply recommended fixes from the analyzer.
- Keep code short, documented, and avoid adding unused files. If a file is not used, remove it.

## Testing

- Run `flutter test` to execute unit and widget tests.
- The repository includes tests that set up a `DefaultAssetBundle` for stable image resolution in tests.
- For integration/e2e tests that require window sizing, the tests use the testing APIs (`WidgetTester.view`) in test files.

## Pre-merge checklist (mandatory)

- [ ] All tests pass locally: `flutter test` (unit/widget/integration smoke tests)
- [ ] `flutter analyze` reports no errors and only acceptable info/warnings
- [ ] `dart fix --apply` and `dart format .` run and changes are committed
- [ ] `CHANGELOG.md` updated with user-facing and developer-facing notes for this PR
- [ ] PR description updated with a short summary, what to review, and any manual QA steps
- [ ] If the change affects visuals, add golden tests or attach screenshots in the PR
- [ ] Add or update `DEV_NOTES.md` for any special setup or test behavior

## Notes for reviewers

- Check RTL layout and Arabic strings for accuracy and truncation.
- Verify tracking & favorites flows (follow/unfollow persists across restarts).
- Verify that the `All Screens` page is reachable via **Settings → عرض كل الشاشات**.

Thank you — small, consistent steps help keep this project healthy.
