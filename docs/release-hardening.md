# Release hardening

This document describes the current release packaging baseline and the minimum follow-up required when turning this template into a real application.

## Goals

- Keep release packaging close to standard Flutter and Android workflows
- Make release outputs reproducible in local Docker and CI
- Leave secrets and signing material outside the repository

## Current baseline

- Release APK build is supported
- Release AAB build is supported
- GitLab tag pipelines publish web and AAB artifacts
- Codemagic tag workflows build Android, web, Linux, and Windows artifacts
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

## GitLab release artifacts

Tag pipelines matching `v*.*.*` publish:

- `build/web/`
- `build/app/outputs/bundle/release/*.aab`

This keeps the template close to a practical release baseline without forcing store upload automation into the starter itself.

## Project-specific follow-up

Before shipping a real app:

1. Replace placeholder app metadata
2. Add real Android signing material
3. Add project-specific secret management in CI and Codemagic
4. Decide whether store submission should stay manual or be automated later
