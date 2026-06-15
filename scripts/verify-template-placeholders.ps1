param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$ExpectedAppName,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$ExpectedBrandName,

    [Parameter()]
    [ValidatePattern('^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)+$')]
    [string]$ExpectedApplicationId,

    [Parameter()]
    [ValidatePattern('^https?://')]
    [string]$ExpectedApiBaseUrl,

    [Parameter()]
    [ValidatePattern('^[a-z][a-z0-9_]*$')]
    [string]$ExpectedPackageName,

    [Parameter()]
    [ValidatePattern('^[a-z][a-z0-9_]*$')]
    [string]$ExpectedBinaryName
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-RelativePath {
    param([Parameter(Mandatory = $true)][string]$Path)

    return ($Path -replace '\\', '/').TrimStart('./')
}

function Convert-ToSnakeCase {
    param([Parameter(Mandatory = $true)][string]$Value)

    $normalized = $Value.Trim().ToLowerInvariant() -replace '[^a-z0-9]+', '_'
    $normalized = $normalized.Trim('_')
    if (-not $normalized) {
        throw 'Could not derive an expected package name from ExpectedAppName. Pass -ExpectedPackageName explicitly.'
    }
    if ($normalized[0] -match '[0-9]') {
        $normalized = "app_$normalized"
    }
    return $normalized
}

function Read-TextFile {
    param([Parameter(Mandatory = $true)][string]$Path)

    $resolved = Resolve-Path -LiteralPath $Path
    $bytes = [IO.File]::ReadAllBytes($resolved)
    if ([Array]::IndexOf($bytes, [byte]0) -ge 0) {
        return $null
    }
    return [IO.File]::ReadAllText($resolved)
}

function Add-Finding {
    param(
        [Parameter()]
        [System.Collections.Generic.List[object]]$Findings,

        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    $Findings.Add([pscustomobject]@{
        Path = $Path
        Message = $Message
    })
}

if ($ExpectedAppName -and -not $ExpectedBrandName) {
    $ExpectedBrandName = $ExpectedAppName
}
if ($ExpectedAppName -and -not $ExpectedPackageName) {
    $ExpectedPackageName = Convert-ToSnakeCase -Value $ExpectedAppName
}
if ($ExpectedPackageName -and -not $ExpectedBinaryName) {
    $ExpectedBinaryName = $ExpectedPackageName
}

$trackedFiles = & git ls-files
if ($LASTEXITCODE -ne 0) {
    throw 'git ls-files failed. Run this script from a git checkout.'
}

$excludedPrefixes = @(
    'docs/reference/'
)

$excludedFiles = @(
    'scripts/new_app.ps1',
    'scripts/verify-template-placeholders.ps1'
)

$candidateFiles = foreach ($file in $trackedFiles) {
    $relative = Get-RelativePath -Path $file
    $isExcluded = $false
    foreach ($prefix in $excludedPrefixes) {
        if ($relative.StartsWith($prefix, [StringComparison]::OrdinalIgnoreCase)) {
            $isExcluded = $true
            break
        }
    }
    if (-not $isExcluded -and -not ($excludedFiles -contains $relative)) {
        $relative
    }
}

$forbiddenValues = [ordered]@{
    'flutter_app_template' = 'template Dart package name'
    'package:flutter_app_template/' = 'template Dart package import'
    'com.example.template.app' = 'template application ID'
    'https://api.example.com' = 'template API base URL'
    'Template App' = 'template visible app name'
    'Template Brand' = 'template brand name'
    'template_app' = 'template native binary name'
    'com.example.template' = 'template company/application prefix'
    'android/app/src/main/kotlin/com/example/template/flutter_app_template' = 'template Android package path'
}

$findings = New-Object System.Collections.Generic.List[object]

foreach ($file in $candidateFiles) {
    if (-not (Test-Path -LiteralPath $file -PathType Leaf)) {
        continue
    }

    $text = Read-TextFile -Path $file
    if ($null -eq $text) {
        continue
    }

    foreach ($entry in $forbiddenValues.GetEnumerator()) {
        if ($text.Contains($entry.Key)) {
            Add-Finding -Findings $findings -Path $file -Message ("contains {0}: {1}" -f $entry.Value, $entry.Key)
        }
    }
}

$requiredChecks = @()
if ($ExpectedPackageName) {
    $requiredChecks += [pscustomobject]@{
        Path = 'pubspec.yaml'
        Pattern = "(?m)^name:\s+$([regex]::Escape($ExpectedPackageName))\s*$"
        Message = "pubspec.yaml name is not $ExpectedPackageName"
    }
    $requiredChecks += [pscustomobject]@{
        Path = 'lib/main.dart'
        Pattern = "package:$([regex]::Escape($ExpectedPackageName))/"
        Message = "Dart imports do not use package:$ExpectedPackageName/"
    }
}
if ($ExpectedApplicationId) {
    $requiredChecks += [pscustomobject]@{
        Path = 'android/app/build.gradle.kts'
        Pattern = [regex]::Escape($ExpectedApplicationId)
        Message = "Android namespace/applicationId does not include $ExpectedApplicationId"
    }
    $requiredChecks += [pscustomobject]@{
        Path = 'linux/CMakeLists.txt'
        Pattern = [regex]::Escape($ExpectedApplicationId)
        Message = "Linux APPLICATION_ID does not include $ExpectedApplicationId"
    }
}
if ($ExpectedAppName) {
    $requiredChecks += [pscustomobject]@{
        Path = 'android/app/src/main/AndroidManifest.xml'
        Pattern = [regex]::Escape("android:label=`"$ExpectedAppName`"")
        Message = "Android launcher label is not $ExpectedAppName"
    }
    $requiredChecks += [pscustomobject]@{
        Path = 'web/index.html'
        Pattern = [regex]::Escape("<title>$ExpectedAppName</title>")
        Message = "Web title is not $ExpectedAppName"
    }
    $requiredChecks += [pscustomobject]@{
        Path = 'web/manifest.json'
        Pattern = [regex]::Escape("`"name`": `"$ExpectedAppName`"")
        Message = "Web manifest name is not $ExpectedAppName"
    }
}
if ($ExpectedApiBaseUrl) {
    $requiredChecks += [pscustomobject]@{
        Path = 'lib/app/config/app_defines.dart'
        Pattern = [regex]::Escape($ExpectedApiBaseUrl)
        Message = "App defines do not include $ExpectedApiBaseUrl"
    }
}
if ($ExpectedBinaryName) {
    $requiredChecks += [pscustomobject]@{
        Path = 'linux/CMakeLists.txt'
        Pattern = [regex]::Escape("set(BINARY_NAME `"$ExpectedBinaryName`")")
        Message = "Linux binary name is not $ExpectedBinaryName"
    }
    $requiredChecks += [pscustomobject]@{
        Path = 'windows/CMakeLists.txt'
        Pattern = [regex]::Escape("project($ExpectedBinaryName LANGUAGES CXX)")
        Message = "Windows project name is not $ExpectedBinaryName"
    }
}

foreach ($check in $requiredChecks) {
    if (-not (Test-Path -LiteralPath $check.Path -PathType Leaf)) {
        Add-Finding -Findings $findings -Path $check.Path -Message 'required file is missing'
        continue
    }

    $text = Read-TextFile -Path $check.Path
    if ($null -eq $text -or $text -notmatch $check.Pattern) {
        Add-Finding -Findings $findings -Path $check.Path -Message $check.Message
    }
}

if ($findings.Count -gt 0) {
    Write-Host 'Template placeholder verification FAILED'
    foreach ($finding in $findings) {
        Write-Host ("{0}: {1}" -f $finding.Path, $finding.Message)
    }
    exit 1
}

Write-Host 'Template placeholder verification passed.'
if ($ExpectedAppName) {
    Write-Host "ExpectedAppName:       $ExpectedAppName"
}
if ($ExpectedBrandName) {
    Write-Host "ExpectedBrandName:     $ExpectedBrandName"
}
if ($ExpectedApplicationId) {
    Write-Host "ExpectedApplicationId: $ExpectedApplicationId"
}
if ($ExpectedApiBaseUrl) {
    Write-Host "ExpectedApiBaseUrl:    $ExpectedApiBaseUrl"
}
if ($ExpectedPackageName) {
    Write-Host "ExpectedPackageName:   $ExpectedPackageName"
}
if ($ExpectedBinaryName) {
    Write-Host "ExpectedBinaryName:    $ExpectedBinaryName"
}
