# learn-flutter review for `flutter_app_template`

This note summarizes what from `learn-flutter` is worth reflecting in this template, what should stay out for now, and what is worth changing next.

Reference source:

- `docs/reference/learn-flutter-llms-full-2026-04-13.txt`

## Reflect in this template

- Keep `go_router` and `flutter_riverpod` as the current baseline
- Keep the feature-first layout with `app`, `core`, and `features`
- Strengthen environment guidance for `dev`, `stage`, and `prod`
- Make test layers easier to understand for new app teams
- Keep dependency and code generation maintenance documented

## Do not reflect right now

- Full clean architecture layering as a default
- Monorepo or `melos`-based setup
- App-specific integrations such as Sentry, social login, or analytics defaults
- Heavy Riverpod generator patterns as a required baseline
- Full flavor complexity before a real app actually needs it

## Immediate follow-up candidates

1. Improve release and environment documentation
2. Clarify unit, widget, and integration test expectations
3. Keep Android and web release paths explicit
4. Evaluate WidgetBook later during UI and structure hardening
