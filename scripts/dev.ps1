param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet('setup', 'gen', 'lint', 'test', 'ci', 'build-web', 'build-android', 'build-aab', 'build-linux', 'run', 'shell')]
    [string]$Task,

    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$ExtraArgs
)

$appEnv = if ($env:APP_ENV) { $env:APP_ENV } else { 'dev' }
$appName = if ($env:APP_NAME) { $env:APP_NAME } else { 'Template App' }
$brandName = if ($env:BRAND_NAME) { $env:BRAND_NAME } else { 'Template Brand' }
$applicationId = if ($env:APPLICATION_ID) { $env:APPLICATION_ID } else { 'com.example.template.app' }
$apiBaseUrl = if ($env:API_BASE_URL) { $env:API_BASE_URL } else { 'https://api.example.com' }

$dockerArgs = @('compose', 'run', '--rm', 'flutter')
$flutterDefines = @(
    "--dart-define=APP_ENV=$appEnv",
    "--dart-define=APP_NAME=$appName",
    "--dart-define=BRAND_NAME=$brandName",
    "--dart-define=APPLICATION_ID=$applicationId",
    "--dart-define=API_BASE_URL=$apiBaseUrl"
)

switch ($Task) {
    'setup' { & docker @dockerArgs flutter pub get }
    'gen' { & docker @dockerArgs dart run build_runner build }
    'lint' { & docker @dockerArgs flutter analyze }
    'test' { & docker @dockerArgs flutter test }
    'ci' {
        & docker @dockerArgs dart format --output=none --set-exit-if-changed .
        if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
        & docker @dockerArgs dart run build_runner build
        if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
        & git diff --exit-code
        if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
        & docker @dockerArgs flutter analyze
        if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
        & docker @dockerArgs flutter test
        if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
        & docker @dockerArgs flutter build web --release @flutterDefines @ExtraArgs
    }
    'build-web' { & docker @dockerArgs flutter build web --release @flutterDefines @ExtraArgs }
    'build-android' { & docker @dockerArgs flutter build apk --release @flutterDefines @ExtraArgs }
    'build-aab' { & docker @dockerArgs flutter build appbundle --release @flutterDefines @ExtraArgs }
    'build-linux' { & docker @dockerArgs flutter build linux --release @flutterDefines @ExtraArgs }
    'run' { & docker @dockerArgs flutter run @flutterDefines @ExtraArgs }
    'shell' { & docker @dockerArgs bash @ExtraArgs }
}

exit $LASTEXITCODE
