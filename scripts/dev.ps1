param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet('setup', 'gen', 'lint', 'test', 'ci', 'build-web', 'build-android', 'build-aab', 'build-linux', 'run', 'shell')]
    [string]$Task,

    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$ExtraArgs
)

$makeArgs = @($Task) + $ExtraArgs

& make @makeArgs
exit $LASTEXITCODE
