# Platform baseline

This document records what has been validated in the template and where platform-specific follow-up work is expected.

## Verified baseline

- Android APK build
- Android AAB build verified
- Web release build
- Linux release build
- Windows project files generated and committed
- GitHub Actions validation workflow
- GitLab CI validation on `ct102-docker-runner`
- Codemagic workflow templates present but not remotely verified

## Android

### Current status

- APK build verified
- AAB build verified
- Default Android namespace and application ID are placeholder values
- Release signing falls back to debug signing until `android/key.properties` is added

### Paths

- APK: `build/app/outputs/flutter-apk/app-release.apk`
- AAB: `build/app/outputs/bundle/release/app-release.aab` after running the AAB build

### Project-specific follow-up

- Replace `applicationId` and `namespace`
- Add `android/key.properties` and a real release signing configuration
- Store keystore material outside the repository
- Decide whether GitLab and any external delivery service should receive signing material or build unsigned baseline artifacts only

## Web

### Current status

- Release build verified
- Template metadata exists in `web/index.html` and `web/manifest.json`

### Project-specific follow-up

- Replace app title and description
- Replace icons and manifest branding
- Add hosting or deployment configuration

## Linux

### Current status

- Linux release build verified

### Project-specific follow-up

- Replace product metadata if needed
- Package the app for your target distribution model

## Windows

### Current status

- Windows project files are present
- Windows CI and local toolchain are intentionally not required on the host

### Project-specific follow-up

- Replace Windows product metadata
- Build and package from a Windows-capable environment when needed
