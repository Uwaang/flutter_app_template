# Project structure

This repository uses a feature-first structure that stays close to normal Flutter conventions while keeping common infrastructure easy to find.

## Directories

- `lib/main.dart`
  - App entry point
- `lib/app`
  - App bootstrap, configuration, theme, and routing
- `lib/core`
  - Shared app-agnostic infrastructure used across features
- `lib/features`
  - Feature-facing UI and application code
- `assets`
  - Static assets and configuration files
- `test`
  - Unit and widget tests
- `integration_test`
  - Integration test entry point

## Current layout

- `lib/app/bootstrap`
  - Application startup and provider setup
- `lib/app/config`
  - Compile-time values and typed app configuration
- `lib/app/router`
  - Route definitions and navigation setup
- `lib/app/theme`
  - Theme and color system
- `lib/core/network`
  - Shared HTTP client configuration
- `lib/core/error`
  - `Result`, `AppException`, and `AppFailure` for consistent failure mapping
- `lib/core/logging`
  - Logger abstraction and replaceable sinks
- `lib/core/storage`
  - Key-value store abstraction and SharedPreferences adapter
- `lib/core/widgets`
  - Reusable UI building blocks
- `lib/features/about`
  - App metadata and project-link placeholders
- `lib/features/debug`
  - Feature-flagged runtime diagnostics
- `lib/features/home`
  - Starter home feature
- `lib/features/settings`
  - Starter settings feature

## Working rules

- Put app-wide concerns in `lib/app`
- Put reusable infrastructure in `lib/core`
- Put user-facing flows in `lib/features`
- Avoid introducing a package split until repeated cross-repository maintenance becomes real

## Why this structure

- It is easy for Flutter developers to navigate
- It keeps project-wide setup separate from feature code
- It supports growth without forcing a complex architecture too early
