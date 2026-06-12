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
- `flutter analyze`
- `flutter test`
- code generation
- generated diff check
- web smoke build

## GitLab CI baseline

Confirm that `.gitlab-ci.yml` passes on the project runner:

- Flutter image boot
- dependency resolution
- analysis
- tests
- code generation
- generated diff check
- release web build
- release AAB build on version tags

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
- CI artifact expectations for web and Android are still valid
