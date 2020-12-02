$parentDirectoryName = (Split-Path $pwd -Leaf)
if ($parentDirectoryName -notmatch "^adventofcode\d{4}$") {
    Write-Error "Parent dir must be named 'adventofcodeYYYY' where YYYY holds a number indicating the year."
}

for ($i = 1; $i -le 25; $i++) {
    $day = "day$i"
    
    $folderToCreate = Join-Path -Path $pwd -ChildPath $day
    New-Item -Path $folderToCreate -ItemType Directory
    
    $filesToCreate = "$day-1.ps1", "$day-2.ps1", "input.ps1" | ForEach-Object { Join-Path -path $pwd -ChildPath $_ }
    $filesToCreate | ForEach-Object {
        New-Item -Path $_ -ItemType File
    }
    
    $fileContents = Get-Content $filesToCreate[0]
    if ([string]::IsNullOrEmpty($fileContents)) {
        Set-Content -Path $filesToCreate -Value @'
# example input
$in = @"
"@

# puzzle input
# Get-Content -Path .\input.txt

'@
    }
}