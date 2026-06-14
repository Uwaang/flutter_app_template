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
- NAS GitLab tag pipelines publish web artifacts automatically and keep AAB artifacts manual
- Codemagic tag workflows are defined for Android, web, Linux, and Windows, but are not part of the currently verified delivery path
- Android release signing falls back to the debug key until `android/key.properties` is added

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

- Template repository: keep `REQUIRE_ANDROID_SIGNING=false`
- Real app production repository: set `REQUIRE_ANDROID_SIGNING=true` for protected tag builds

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

- `${repository}-${tag}-web`
- `${repository}-${tag}-android-aab`

This is the preferred full release validation path for a public mirror or public template repository.

## NAS GitLab release artifacts

Tag pipelines matching `v*.*.*` publish:

- `build/web/`

Artifact names:

- `${project}-${tag}-web`

The Android AAB artifact job exists but is manual and allowed to fail. The NAS GitLab runner is intended for lightweight private validation, while full Android artifact validation should run on GitHub Actions or a stronger runner.

## Codemagic status

`codemagic.yaml` is kept as a future external delivery template. The current repository remote is a NAS-hosted GitLab URL that is not expected to be reachable from Codemagic cloud builds.

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
