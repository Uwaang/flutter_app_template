# Release hardening

This document describes the current release packaging baseline and the minimum follow-up required when turning this template into a real application.

## Goals

- Keep release packaging close to standard Flutter and Android workflows
- Make release outputs reproducible in local Docker and CI
- Leave secrets and signing material outside the repository

## Current baseline

- Release APK build is supported
- Release AAB build is supported
- GitHub tag workflows publish web and AAB artifacts for public-repo full validation
- Self-hosted GitLab tag pipelines publish web artifacts automatically and keep AAB artifacts manual by default
- Codemagic tag workflows are defined for Android, web, Linux, and Windows, but are not part of the currently verified delivery path
- Android release signing falls back to the debug key until `android/key.properties` is added
- GitHub tag releases run a preflight guard that rejects production template placeholders and requires Android signing
- Manual GitHub release workflow dispatch is an explicit test-artifact path by default

## Android signing

The template uses the common Flutter and Android pattern of loading signing data from `android/key.properties`.

Files:

- Example file: `android/key.properties.example`
- Real file: `android/key.properties` (ignored by git)

Required keys:

- `storeFile`
- `storePassword`
- `keyAlias`
- `keyPassword`

Recommended setup:

1. Copy `android/key.properties.example` to `android/key.properties`
2. Update the values for the real keystore location and credentials
3. Keep the keystore file itself outside the repository or inject it in CI

Until that file exists, release Android builds stay buildable by using the debug signing configuration.

## CI signing secret injection

GitLab CI and the prepared Codemagic workflows use the shared script `scripts/setup-android-signing.sh`.

Supported environment variables:

- `ANDROID_KEYSTORE_BASE64`
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_ALIAS`
- `ANDROID_KEY_PASSWORD`
- `ANDROID_KEYSTORE_FILE_NAME` (optional, defaults to `upload-keystore.jks`)
- `REQUIRE_ANDROID_SIGNING` (`true` or `false`)

Behavior:

- When `ANDROID_KEYSTORE_BASE64` is present, the script restores the keystore into `android/keystore/` and writes `android/key.properties`
- When signing variables are missing and `REQUIRE_ANDROID_SIGNING=true`, the build fails early
- When signing variables are missing and `REQUIRE_ANDROID_SIGNING=false`, the template keeps using debug signing so the build stays reproducible

Recommended policy:

- Template repository: keep `REQUIRE_ANDROID_SIGNING=false` only for manual test-artifact dispatches
- Real app production repository: set `REQUIRE_ANDROID_SIGNING=true` for protected tag builds
- GitHub tag releases enforce `REQUIRE_ANDROID_SIGNING=true`; missing `ANDROID_KEYSTORE_BASE64` fails before the Android build starts

## Release preflight

GitHub release jobs run [`scripts/validate-release-config.sh`](../scripts/validate-release-config.sh) before dependency installation.

The preflight checks:

- `APP_ENV` is one of `ci`, `dev`, `development`, `stage`, `staging`, `prod`, or `production`
- `APP_NAME`, `BRAND_NAME`, `APPLICATION_ID`, and `API_BASE_URL` are not blank
- `APPLICATION_ID` is a reverse-DNS identifier
- `API_BASE_URL` is an absolute `http` or `https` URL
- production releases do not use `Template App`, `Template Brand`, `com.example.template.app`, or `https://api.example.com`
- tag releases use `APP_ENV=prod` or `production`
- tag releases do not allow template placeholders
- tag releases require Android signing

Manual `workflow_dispatch` runs default to `APP_ENV=ci`, `ALLOW_TEMPLATE_PLACEHOLDERS=true`, and `REQUIRE_ANDROID_SIGNING=false`. Use this only for template/test artifacts. A real app release should dispatch with production values, `ALLOW_TEMPLATE_PLACEHOLDERS=false`, and `REQUIRE_ANDROID_SIGNING=true`.

## Local release commands

From the repository root:

```bash
make build-android
make build-aab
```

On Windows:

```powershell
./scripts/dev.ps1 build-android
./scripts/dev.ps1 build-aab
```

Expected outputs:

- APK: `build/app/outputs/flutter-apk/app-release.apk`
- AAB: `build/app/outputs/bundle/release/app-release.aab`

## GitHub release artifacts

Tag workflows matching `v*.*.*` publish:

- `build/web/`
- `build/app/outputs/bundle/release/*.aab`

Artifact names:

- `${repository}-${tag}-${commitSha}-web`
- `${repository}-${tag}-${commitSha}-android-aab`

This is the preferred full release validation path for a public mirror or public template repository.

If a repository setting or GitHub-side event issue prevents a tag push from enqueueing the workflow, run the same release workflow manually:

```bash
gh workflow run release.yml --repo OWNER/REPOSITORY --ref vX.Y.Z
```

Confirm the run completes and the web/AAB artifacts are present before treating the tag as validated.

Manual dispatch inputs control whether the run is a test-artifact build or a production-like validation. Keep the default test inputs for the public template itself; set production app values and disable placeholder allowance for a real app.

## Docker image strategy

Local Docker and `docker compose` builds default to a pinned Flutter image digest:

```text
ghcr.io/cirruslabs/flutter:stable@sha256:7f429b29a9568705def6308f94458633e7c21d8dcf14fe6e1762f9ced3ba83b8
```

This keeps local validation reproducible even when the upstream `stable` tag moves. To intentionally refresh the toolchain, override `FLUTTER_IMAGE` for a test build, run the full verification checklist, then update the pinned digest in [`docker/Dockerfile`](../docker/Dockerfile) and [`docker-compose.yml`](../docker-compose.yml) together.

## Self-hosted GitLab release artifacts

Tag pipelines matching `v*.*.*` publish:

- `build/web/`

Artifact names:

- `${project}-${tag}-web`

The Android AAB artifact job exists but is manual and allowed to fail. This keeps self-hosted runners focused on lightweight private validation, while full Android artifact validation should run on GitHub Actions or a stronger runner.

## Codemagic status

`codemagic.yaml` is kept as a future external delivery template. Codemagic requires the repository to be reachable from Codemagic cloud builds and requires an account connected to the app.

Before treating Codemagic as an active release path:

1. Mirror the repository to an externally reachable Git provider or otherwise make the repository cloneable from Codemagic
2. Create or connect a Codemagic account for the app
3. Confirm access to the configured `linux_x2` and `windows_x2` instance types
4. Run Android and web workflows first, then Linux and Windows

## Project-specific follow-up

Before shipping a real app:

1. Replace placeholder app metadata
2. Add real Android signing material
3. Add project-specific secret management in CI and any active external delivery service
4. Decide whether store submission should stay manual or be automated later
