param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$AppName,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$BrandName,

    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)+$')]
    [string]$ApplicationId,

    [Parameter(Mandatory = $true)]
    [ValidatePattern('^https?://')]
    [string]$ApiBaseUrl,

    [Parameter()]
    [ValidatePattern('^[a-z][a-z0-9_]*$')]
    [string]$PackageName,

    [Parameter()]
    [ValidatePattern('^[a-z][a-z0-9_]*$')]
    [string]$BinaryName,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$Description,

    [Parameter()]
    [switch]$Apply
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Convert-ToSnakeCase {
    param([Parameter(Mandatory = $true)][string]$Value)

    $normalized = $Value.Trim().ToLowerInvariant() -replace '[^a-z0-9]+', '_'
    $normalized = $normalized.Trim('_')
    if (-not $normalized) {
        throw 'Could not derive a package name from AppName. Pass -PackageName explicitly.'
    }
    if ($normalized[0] -match '[0-9]') {
        $normalized = "app_$normalized"
    }
    return $normalized
}

function Get-RelativePath {
    param([Parameter(Mandatory = $true)][string]$Path)

    return ($Path -replace '\\', '/').TrimStart('./')
}

function Convert-ApplicationIdToPath {
    param([Parameter(Mandatory = $true)][string]$Value)

    return ($Value -split '\.') -join [IO.Path]::DirectorySeparatorChar
}

if (-not $BrandName) {
    $BrandName = $AppName
}
if (-not $PackageName) {
    $PackageName = Convert-ToSnakeCase -Value $AppName
}
if (-not $BinaryName) {
    $BinaryName = $PackageName
}
if (-not $Description) {
    $Description = "$AppName is a Flutter app created from flutter_app_template."
}

$companyName = ($ApplicationId -split '\.')[0..([Math]::Max(0, ($ApplicationId -split '\.').Length - 2))] -join '.'

$oldAndroidPackagePath = 'android/app/src/main/kotlin/com/example/template/flutter_app_template'
$newAndroidPackagePath = Join-Path 'android/app/src/main/kotlin' (Convert-ApplicationIdToPath -Value $ApplicationId)
$oldMainActivity = Join-Path $oldAndroidPackagePath 'MainActivity.kt'
$newMainActivity = Join-Path $newAndroidPackagePath 'MainActivity.kt'

$old = @{
    AppName = 'Template App'
    BrandName = 'Template Brand'
    ApplicationId = 'com.example.template.app'
    ApiBaseUrl = 'https://api.example.com'
    PackageName = 'flutter_app_template'
    BinaryName = 'template_app'
    CompanyName = 'com.example.template'
    AndroidPackagePath = $oldAndroidPackagePath
    WebDescription = 'Template App is a Docker-first Flutter boilerplate for new projects.'
}

$replacements = [ordered]@{
    $old.WebDescription = $Description
    $old.AndroidPackagePath = (Get-RelativePath -Path $newAndroidPackagePath)
    $old.AppName = $AppName
    $old.BrandName = $BrandName
    $old.ApplicationId = $ApplicationId
    $old.ApiBaseUrl = $ApiBaseUrl
    $old.PackageName = $PackageName
    $old.BinaryName = $BinaryName
    $old.CompanyName = $companyName
}

$trackedFiles = & git ls-files
if ($LASTEXITCODE -ne 0) {
    throw 'git ls-files failed. Run this script from a git checkout.'
}

$excludedPrefixes = @(
    'docs/reference/',
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
    if (-not $isExcluded) {
        $relative
    }
}

$changes = New-Object System.Collections.Generic.List[object]

foreach ($file in $candidateFiles) {
    if (-not (Test-Path -LiteralPath $file -PathType Leaf)) {
        continue
    }

    $bytes = [IO.File]::ReadAllBytes((Resolve-Path -LiteralPath $file))
    if ([Array]::IndexOf($bytes, [byte]0) -ge 0) {
        continue
    }

    $text = [IO.File]::ReadAllText((Resolve-Path -LiteralPath $file))
    $updated = $text
    $count = 0

    foreach ($pair in $replacements.GetEnumerator()) {
        $before = $updated
        $updated = $updated.Replace($pair.Key, $pair.Value)
        if ($before -ne $updated) {
            $count += ([regex]::Matches($before, [regex]::Escape($pair.Key))).Count
        }
    }

    if ($text -ne $updated) {
        $changes.Add([pscustomobject]@{
            Type = 'edit'
            Path = $file
            Replacements = $count
        })
        if ($Apply) {
            [IO.File]::WriteAllText((Resolve-Path -LiteralPath $file), $updated)
        }
    }
}

if (Test-Path -LiteralPath $oldMainActivity -PathType Leaf) {
    $changes.Add([pscustomobject]@{
        Type = 'move'
        Path = $oldMainActivity
        Replacements = 0
        Destination = $newMainActivity
    })

    if ($Apply) {
        if (Test-Path -LiteralPath $newMainActivity) {
            throw "Target MainActivity already exists: $newMainActivity"
        }
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $newMainActivity) | Out-Null
        Move-Item -LiteralPath $oldMainActivity -Destination $newMainActivity

        $pathToClean = Split-Path -Parent $oldMainActivity
        while ($pathToClean -and $pathToClean -ne 'android/app/src/main/kotlin') {
            if ((Get-ChildItem -LiteralPath $pathToClean -Force | Measure-Object).Count -eq 0) {
                Remove-Item -LiteralPath $pathToClean -Force
                $pathToClean = Split-Path -Parent $pathToClean
            } else {
                break
            }
        }
    }
}

$mode = if ($Apply) { 'APPLY' } else { 'DRY-RUN' }
Write-Host "new_app.ps1 $mode"
Write-Host "AppName:       $AppName"
Write-Host "BrandName:     $BrandName"
Write-Host "ApplicationId: $ApplicationId"
Write-Host "ApiBaseUrl:    $ApiBaseUrl"
Write-Host "PackageName:   $PackageName"
Write-Host "BinaryName:    $BinaryName"
Write-Host ''

if ($changes.Count -eq 0) {
    Write-Host 'No template placeholders found.'
} else {
    foreach ($change in $changes) {
        if ($change.Type -eq 'move') {
            Write-Host ("move {0} -> {1}" -f $change.Path, $change.Destination)
        } else {
            Write-Host ("edit {0} ({1} replacements)" -f $change.Path, $change.Replacements)
        }
    }
}

if (-not $Apply) {
    Write-Host ''
    Write-Host 'No files were changed. Re-run with -Apply to write these changes.'
} else {
    Write-Host ''
    Write-Host 'Next verification command:'
    Write-Host ("./scripts/verify-template-placeholders.ps1 -ExpectedAppName ""{0}"" -ExpectedBrandName ""{1}"" -ExpectedApplicationId ""{2}"" -ExpectedApiBaseUrl ""{3}"" -ExpectedPackageName ""{4}"" -ExpectedBinaryName ""{5}""" -f $AppName, $BrandName, $ApplicationId, $ApiBaseUrl, $PackageName, $BinaryName)
}
