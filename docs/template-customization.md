# Template customization checklist

Use this checklist every time you create a new repository from `flutter_app_template`.

## Replace identifiers

- Update `APP_NAME`, `BRAND_NAME`, `APPLICATION_ID`, and `API_BASE_URL`
- Replace the default Android application ID in [android/app/build.gradle.kts](../android/app/build.gradle.kts)
- Replace the Kotlin package declaration in [android/app/src/main/kotlin/com/example/template/flutter_app_template/MainActivity.kt](../android/app/src/main/kotlin/com/example/template/flutter_app_template/MainActivity.kt)
- Replace the Linux application ID in [linux/CMakeLists.txt](../linux/CMakeLists.txt)

## Replace visible branding

- Update the title and metadata in [web/index.html](../web/index.html)
- Update the web manifest in [web/manifest.json](../web/manifest.json)
- Update the Windows product metadata in [windows/runner/Runner.rc](../windows/runner/Runner.rc)
- Replace launcher icons and splash assets

## Configure CI/CD

- Add GitHub branch protection and required checks for `.github/workflows/ci.yml`
- Confirm the NAS GitLab runner tags in `.gitlab-ci.yml` match the target project runner configuration
- Configure Codemagic environment groups and signing credentials
- Replace the placeholder production API URL and environment values in [codemagic.yaml](../codemagic.yaml)

## App implementation

- Replace the example `home` and `settings` features with real app flows
- Move any repeated code into a shared package repository only after it becomes a maintenance burden across multiple app repos
