# Template customization checklist

Use this checklist after creating a new repository from `flutter_app_template`.

## 1. Update compile-time configuration

- Replace the placeholder values passed through `--dart-define`
- Confirm the defaults in [`lib/app/config/app_defines.dart`](../lib/app/config/app_defines.dart)
- Update the starter manifest in [`assets/config/brand_defaults.json`](../assets/config/brand_defaults.json)

Recommended values to replace first:

- `APP_NAME`
- `BRAND_NAME`
- `APPLICATION_ID`
- `API_BASE_URL`
- `APP_ENV`

## 2. Update platform identifiers

- Android namespace and application ID: [`android/app/build.gradle.kts`](../android/app/build.gradle.kts)
- Android launcher label: [`android/app/src/main/AndroidManifest.xml`](../android/app/src/main/AndroidManifest.xml)
- Android Kotlin package path: [`android/app/src/main/kotlin/com/example/template/flutter_app_template/MainActivity.kt`](../android/app/src/main/kotlin/com/example/template/flutter_app_template/MainActivity.kt)
- Linux metadata: [`linux/CMakeLists.txt`](../linux/CMakeLists.txt)
- Windows metadata: [`windows/runner/Runner.rc`](../windows/runner/Runner.rc)

## 3. Update visible app branding

- App title and web metadata: [`web/index.html`](../web/index.html)
- Web manifest: [`web/manifest.json`](../web/manifest.json)
- Starter copy shown in the app: [`lib/features/home/presentation/home_screen.dart`](../lib/features/home/presentation/home_screen.dart)
- Theme and color system: [`lib/app/theme/app_theme.dart`](../lib/app/theme/app_theme.dart)
- Replace launcher icons and splash assets as needed

## 4. Confirm the build workflow

- Run the local verification checklist in [`docs/verification-checklist.md`](./verification-checklist.md)
- Confirm GitHub Actions passes
- Confirm GitLab CI passes on the assigned runner
- Replace placeholder environment values in [`codemagic.yaml`](../codemagic.yaml)

## 5. Prepare Android release configuration

- Verify APK generation
- Verify AAB generation
- Replace the default debug signing approach in [`android/app/build.gradle.kts`](../android/app/build.gradle.kts)
- Store signing credentials outside the repository

## 6. Replace starter feature content

- Replace the example `home` and `settings` flows with real app features
- Keep the current structure unless repeated maintenance clearly justifies a shared package split
