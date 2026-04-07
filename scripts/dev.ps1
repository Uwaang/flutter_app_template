param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet('setup', 'gen', 'lint', 'test', 'ci', 'build-web', 'build-android', 'build-linux', 'run', 'shell')]
    [string]$Task,

    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$ExtraArgs
)

$defineArgs = @(
    '--dart-define', 'APP_ENV=dev',
    '--dart-define', 'APP_NAME=Template App',
    '--dart-define', 'BRAND_NAME=Template Brand',
    '--dart-define', 'APPLICATION_ID=com.example.template.app',
    '--dart-define', 'API_BASE_URL=https://api.example.com'
)

switch ($Task) {
    'setup' {
        docker compose run --rm flutter bash -lc 'flutter pub get'
    }
    'gen' {
        docker compose run --rm flutter bash -lc 'dart run build_runner build --delete-conflicting-outputs'
    }
    'lint' {
        docker compose run --rm flutter bash -lc 'flutter analyze'
    }
    'test' {
        docker compose run --rm flutter bash -lc 'flutter test'
    }
    'ci' {
        docker compose run --rm flutter bash -lc 'dart format --output=none --set-exit-if-changed . && flutter analyze && flutter test && dart run build_runner build --delete-conflicting-outputs && git diff --exit-code && flutter build web --release --dart-define=APP_ENV=dev --dart-define=APP_NAME=\"Template App\" --dart-define=BRAND_NAME=\"Template Brand\" --dart-define=APPLICATION_ID=com.example.template.app --dart-define=API_BASE_URL=https://api.example.com'
    }
    'build-web' {
        $argsText = ($defineArgs + $ExtraArgs) -join ' '
        docker compose run --rm flutter bash -lc "flutter build web --release $argsText"
    }
    'build-android' {
        $argsText = ($defineArgs + $ExtraArgs) -join ' '
        docker compose run --rm flutter bash -lc "flutter build apk --release $argsText"
    }
    'build-linux' {
        $argsText = ($defineArgs + $ExtraArgs) -join ' '
        docker compose run --rm flutter bash -lc "flutter build linux --release $argsText"
    }
    'run' {
        $argsText = ($defineArgs + $ExtraArgs) -join ' '
        docker compose run --rm -p 8080:8080 flutter bash -lc "flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080 $argsText"
    }
    'shell' {
        docker compose run --rm flutter bash
    }
}
