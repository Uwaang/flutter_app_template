# flutter_app_template

`flutter_app_template` is a practical Flutter starter repository for Android, Web, Linux, and Windows. It keeps the local setup small by running the toolchain inside Docker, while staying close to normal Flutter and general software engineering workflows.

## Goals

- Keep the project familiar to Flutter developers
- Support a single app repository that can ship to multiple platforms
- Avoid requiring Flutter on the host machine
- Provide a clear baseline for CI, release work, and future app customization

## Included stack

- Flutter stable
- `go_router` for app navigation
- `flutter_riverpod` for app wiring and shared configuration
- `dio` for HTTP client setup
- `freezed` and `json_serializable` for generated models
- Docker and devcontainer support
- GitHub Actions for pull request validation
- GitLab CI for self-hosted runner validation
- GitHub Actions release workflow for public-repo web and Android AAB artifacts
- Codemagic workflow templates for future external delivery

## Supported platforms

- Android
- Web
- Linux
- Windows

Current validation baseline is documented in [docs/platform-baseline.md](docs/platform-baseline.md).

## Local requirements

- Git
- Docker Desktop
- An editor such as VS Code or Codex

Flutter is intentionally not required on the host machine.

## Quick start

Use the entrypoint that fits the environment:

- `scripts/dev.ps1` for Windows hosts
- `make` for Unix-like shells and CI

### PowerShell on Windows

```powershell
./scripts/dev.ps1 setup
./scripts/dev.ps1 gen
./scripts/dev.ps1 lint
./scripts/dev.ps1 test
./scripts/dev.ps1 build-web
```

### Make targets

These commands are the canonical local and CI interface:

```bash
make setup
make gen
make lint
make test
make build-web
make build-android
make build-aab
make build-linux
```

## Default configuration

The template ships with buildable placeholder values:

- App name: `Template App`
- Brand name: `Template Brand`
- Application ID: `com.example.template.app`
- API base URL: `https://api.example.com`
- Environment: `dev`

These values are provided through `--dart-define` and read by [`lib/app/config/app_defines.dart`](lib/app/config/app_defines.dart).

### Runtime configuration keys

- `APP_ENV`
- `APP_NAME`
- `BRAND_NAME`
- `APPLICATION_ID`
- `API_BASE_URL`

Examples:

```powershell
./scripts/dev.ps1 run --dart-define APP_ENV=stage --dart-define APP_NAME="Client App"
./scripts/dev.ps1 build-web --dart-define APP_ENV=prod --dart-define API_BASE_URL=https://api.client.example
./scripts/dev.ps1 build-aab --dart-define APP_ENV=prod
```

## Project structure

The project uses a simple feature-first layout:

- `lib/app`: app shell, router, theme, and configuration
- `lib/core`: reusable error/result, logging, storage, network, and widget foundations
- `lib/features`: app-facing feature code
- `assets`: static project assets
- `test` and `integration_test`: automated tests

The current structure guide is in [docs/project-structure.md](docs/project-structure.md).

## Common app-core foundation

The template includes lightweight app-agnostic foundations for common future app work:

- `app/bootstrap`: ordered startup tasks, startup timing diagnostics, and global Flutter/platform/zone error routing through `AppLogger`
- `app/diagnostics`: safe Riverpod provider observer diagnostics for provider lifecycle counts and provider failures
- `app/lifecycle`: app lifecycle hooks that log state changes and can be extended for future autosave, sync, cache, or resource management
- `app/theme`: lightweight spacing and radius tokens used by shared widgets and template screens
- `core/error`: `Result`, `AppException`, and `AppFailure` for consistent low-level error to user-facing failure mapping
- `core/logging`: `AppLogger` and replaceable log sinks, with debug console logging by default
- `core/storage`: a key-value store interface plus a `shared_preferences` implementation for non-sensitive preferences only
- `core/widgets`: reusable app-agnostic UI helpers including loading, empty, error, info, and AsyncValue state rendering widgets
- `app/config/feature_flags.dart`: `ENABLE_DEBUG_MENU`, `ENABLE_MOCK_API`, `ENABLE_NETWORK_LOGGING`, and `ENABLE_PROVIDER_LOGGING`
- `features/settings`, `features/about`, and gated `features/debug` routes

`ENABLE_DEBUG_MENU` is intentionally ignored in production. Debug UI is available only when the flag is enabled and `APP_ENV` is not `prod` or `production`.

`ENABLE_PROVIDER_LOGGING` enables noisy Riverpod provider add, update, and dispose diagnostics only outside production. Provider failures are always routed through `AppLogger`, but provider values are never logged or displayed.

Do not store secrets, tokens, credentials, or personal data in the `shared_preferences` store. Add secure storage later as an explicit app-specific follow-up when a real app needs it. Keep secure storage, crash reporting, analytics, auth, databases, cameras, OpenCV, ONNX, and similar modules as follow-up additions rather than baseline dependencies.

The bootstrap pipeline keeps the default startup work intentionally small: prepare the logger, validate compile-time configuration, configure safe provider diagnostics, capture task timing, then run the app inside the shared Riverpod container. The debug screen surfaces the latest startup and provider diagnostics summaries when the debug route is available.

Common UI states are intentionally quiet and app-agnostic. Use `AppLoadingState`, `AppEmptyState`, `AppErrorState`, and `AsyncValueView` for repeated feature surfaces before introducing app-specific presentation patterns.

## Validation and CI

- GitHub Actions validates formatting, analysis, tests, code generation, and a web smoke build
- GitHub Actions release workflow builds web and Android AAB artifacts on version tags or manual dispatch
- GitLab CI validates the same Flutter workflow on a self-hosted runner and keeps Android AAB artifact builds manual by default
- Codemagic configuration is present, but remote builds require an externally reachable repository mirror and a Codemagic account
- Local Docker builds use a pinned Flutter image digest by default; override `FLUTTER_IMAGE` only when intentionally refreshing the toolchain

The verification checklist lives in [docs/verification-checklist.md](docs/verification-checklist.md).

The CI path is intentionally ordered as format check, code generation, generated diff check, analysis, tests, then web smoke build. This catches stale generated files before analyzer and test failures obscure the source of drift.

Current `build_runner` no longer supports `--delete-conflicting-outputs`; if that option is passed, it is reported as removed and ignored. The template therefore runs `dart run build_runner build` and relies on the generated diff check to fail when committed generated files drift.

## Codex-assisted change workflow

For future Codex-assisted changes, create a branch from `main`, commit the change there, push the branch, and open a pull request for review. Do not push directly to `main`. Keep `main` as the stable baseline and merge only after local validation and GitHub checks pass.

## Android release baseline

- Debug and release APK builds are supported
- Release AAB generation is supported with `build-aab`
- Release signing uses the standard `android/key.properties` pattern when a real app adds its own keystore
- GitHub tag workflows reject production placeholder values, require Android signing material, and keep named web/AAB artifacts that include the commit SHA
- GitHub manual release workflow runs are for explicit test artifacts by default and allow template placeholders only through workflow inputs
- Self-hosted GitLab tag pipelines keep web artifacts automatically; Android AAB artifacts are manual because local runners are often intentionally lightweight
- GitLab CI and future Codemagic builds can restore signing secrets through shared environment variable conventions

See [docs/platform-baseline.md](docs/platform-baseline.md) for the current Android packaging notes and [docs/release-hardening.md](docs/release-hardening.md) for the release setup flow.

## Creating a new app from this template

1. Create a new repository from this template.
2. Update the app name, application ID, API URL, and environment values.
3. Replace visible branding and platform metadata.
4. Confirm local Docker commands and CI pipelines pass.
5. Add project-specific signing, distribution, and release credentials.

Use [docs/template-customization.md](docs/template-customization.md) as the exact checklist.

For Windows-first customization, start with the dry-run generator:

```powershell
./scripts/new_app.ps1 `
  -AppName "Client App" `
  -BrandName "Client Brand" `
  -ApplicationId "com.example.client" `
  -ApiBaseUrl "https://api.client.example"
```

Review the planned file edits, then re-run with `-Apply` to write the changes.

After applying, run the placeholder verification script with the expected app values:

```powershell
./scripts/verify-template-placeholders.ps1 `
  -ExpectedAppName "Client App" `
  -ExpectedBrandName "Client Brand" `
  -ExpectedApplicationId "com.example.client" `
  -ExpectedApiBaseUrl "https://api.client.example" `
  -ExpectedPackageName "client_app" `
  -ExpectedBinaryName "client_app"
```

After applying the generator, stabilize dependencies and run the Docker CI target:

```powershell
./scripts/dev.ps1 setup
git status --short
./scripts/dev.ps1 ci
```

Commit any intentional `pubspec.lock` change from dependency resolution before treating the generated app as verified.

## Branch and release baseline

- `main`: stable baseline
- `develop`: next integration line
- `release/*`: create only when a release stabilization branch is needed
- Tags and release notes are created from `main`

## Shared code policy

Start with one repository per app. If the same code has to be maintained across multiple app repositories, promote that repeated code into a shared package repository later. Until then, keep each application repository independent and easy to reason about.
