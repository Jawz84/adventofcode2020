$fileTemplate = @'
# example input
$in = @"
"@

# puzzle input
# Get-Content -Path .\input.txt

'@

$parentDirectoryName = (Split-Path $pwd -Leaf)
if ($parentDirectoryName -notmatch "^adventofcode\d{4}$") {
    Write-Error "Parent dir must be named 'adventofcodeYYYY' where YYYY holds a number indicating the year."
}

for ($i = 1; $i -le 25; $i++) {
    $day = "day$i"

    $folderToCreate = Join-Path -Path $pwd -ChildPath $day
    $null = New-Item -Path $folderToCreate -ItemType Directory -ErrorAction SilentlyContinue

    $filesToCreate = "$day-1.ps1", "$day-2.ps1", "input.txt" | 
        ForEach-Object { 
            Join-Path -Path $pwd -ChildPath (
                Join-Path -Path $day -ChildPath $_
            )
        }

    $filesToCreate | 
        ForEach-Object {
            $null = New-Item -Path $_ -ItemType File -ErrorAction SilentlyContinue
        }

    $fileContent = Get-Content $filesToCreate[0]

    if ([string]::IsNullOrEmpty($fileContent)) {
        $null = Set-Content -Path $filesToCreate[0] -Value $fileTemplate
    }
}