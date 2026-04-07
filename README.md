# flutter_app_template

`flutter_app_template` is a Docker-first Flutter boilerplate for the `one app per repo` workflow. It targets Android, Web, Linux, and Windows from a single template repository and keeps the host machine requirement intentionally small: `git + docker + editor`.

## What this template includes

- Feature-first Flutter app structure
- `go_router` for navigation
- `flutter_riverpod` for dependency wiring
- `dio` for HTTP client setup
- `freezed` and `json_serializable` for generated models
- Docker and devcontainer setup for local development
- GitHub Actions for PR validation
- GitLab CI for NAS self-hosted runner validation
- Codemagic workflows for build and delivery

## Local requirements

- Git
- Docker Desktop
- An editor such as VS Code or Codex

Flutter is intentionally not required on the host.

## Quick start

### PowerShell on Windows

```powershell
./scripts/dev.ps1 setup
./scripts/dev.ps1 gen
./scripts/dev.ps1 lint
./scripts/dev.ps1 test
./scripts/dev.ps1 build-web
```

### Make targets

These are kept for CI and Unix-like environments:

```bash
make setup
make gen
make lint
make test
make build-web
make build-android
make build-linux
```

## Template defaults

This repository ships with valid placeholder defaults so the project can build immediately:

- App name: `Template App`
- Brand name: `Template Brand`
- Application ID: `com.example.template.app`
- API base URL: `https://api.example.com`
- Environment: `dev`

These defaults are wired through `--dart-define` values and can be overridden without editing Dart code.

## Runtime configuration

The app reads the following compile-time values:

- `APP_ENV`
- `APP_NAME`
- `BRAND_NAME`
- `APPLICATION_ID`
- `API_BASE_URL`

Examples:

```powershell
./scripts/dev.ps1 run --dart-define APP_ENV=stage --dart-define APP_NAME="Client App"
./scripts/dev.ps1 build-web --dart-define APP_ENV=prod --dart-define API_BASE_URL=https://api.client.example
```

## CI/CD flow

- GitHub Actions: format, analyze, test, codegen verification, generated diff check, and web smoke build
- GitLab CI: shell-runner pipeline for Docker-based verification inside the NAS GitLab environment
- Codemagic: Android, Web, Linux, and Windows build workflows

Recommended release flow:

- `pull_request` -> GitHub Actions validation
- `main` merge -> optional dev/stage Codemagic builds
- `v*.*.*` tag -> production Codemagic builds

## Creating a new app from this template

1. Create a new repository from this GitHub template.
2. Replace visible branding and identifiers with your app values.
3. Update the package/application IDs in Android, Linux, and Windows metadata.
4. Replace launcher icons, splash assets, and any brand configuration files.
5. Configure Codemagic environment variables, signing, and distribution targets.

See [docs/template-customization.md](docs/template-customization.md) for the exact checklist.

## Shared code policy

Start by copying this template per app. When repeated edits begin to show up across multiple application repositories, promote those pieces into a shared package repository. Until then, keep each app repo independent and easy to reason about.
