# Verification checklist

Use this checklist after creating a new repository from the template or after changing baseline tooling.

## Local Docker validation

Run the following from the repository root:

```powershell
./scripts/dev.ps1 setup
./scripts/dev.ps1 gen
./scripts/dev.ps1 lint
./scripts/dev.ps1 test
./scripts/dev.ps1 build-web
./scripts/dev.ps1 build-android
./scripts/dev.ps1 build-aab
```

Equivalent Make targets for Unix-like shells and CI:

```bash
make setup
make gen
make lint
make test
make build-web
make build-android
make build-aab
```

## GitHub Actions baseline

Confirm that `.github/workflows/ci.yml` passes:

- format check
- code generation
- generated diff check
- `flutter analyze`
- `flutter test`
- web smoke build

Bootstrap-related changes should also keep the startup task tests, global error reporter tests, lifecycle hook tests, and stable widget tests passing without adding crash-reporting or platform-service dependencies.

Provider diagnostics changes should keep provider observer tests passing, verify provider errors route through `AppLogger`, and confirm noisy provider lifecycle diagnostics are gated by `ENABLE_PROVIDER_LOGGING` and unavailable in production.

The current `build_runner` command is `dart run build_runner build`. The old `--delete-conflicting-outputs` option has been removed upstream and is ignored when passed, so this template intentionally detects generated-output drift with `git diff --exit-code` immediately after generation.

For public release validation, confirm that `.github/workflows/release.yml` passes on a version tag:

- release preflight
- release web build
- release Android AAB build
- web artifact upload
- AAB artifact upload

Tag releases are stricter than manual test builds: they must use production environment values, must reject template placeholders, and must require Android signing.

If the tag push does not create an Actions run, dispatch the workflow manually against the same tag with `gh workflow run release.yml --ref vX.Y.Z` and record the run URL. For the template repository itself, manual dispatch defaults to `APP_ENV=ci`, allows template placeholders, and produces explicit test artifacts.

## GitLab CI baseline

Confirm that `.gitlab-ci.yml` passes on the project runner:

- Flutter image boot
- dependency resolution
- format check
- code generation
- generated diff check
- analysis
- tests
- release web build
- manual release AAB build only when the runner is intentionally selected for that heavier job

The default runner tags are `docker` and `local`. Replace them in `.gitlab-ci.yml` if your self-hosted runner uses a different tag convention.

## Codemagic baseline

Codemagic is currently a prepared but inactive external delivery path. Only use it as a verified baseline after:

- The repository is available from an externally reachable Git remote
- A Codemagic account is connected to the app
- The configured build instance types are available to the account
- Android and web workflows have passed at least once

## Platform sanity check

- Android APK exists after release build
- Android AAB exists after bundle build
- Web output exists in `build/web`
- Linux or Windows packaging is only required when that platform is in scope for the app

## Release readiness check

- `android/key.properties` is present when a real signed Android release is required
- Placeholder app name and application ID have been replaced
- `API_BASE_URL` does not point at `https://api.example.com` for production
- `APP_ENV` is one of the supported environment names
- CI artifact expectations for web and Android are still valid
