# Browse to adventofcode.com, log in using your preferred auth method.
# Open your browsers development tools, and find the Cookie named 'session'.
# For Chrome / Edge that is: F12 > Application > Storage > Cookies > https://adventofcode.com > session
# Store its value in a file named Cookie in the same folder as this script.
$sessionCookie = Get-Content .\Cookie

$ErrorActionPreference = 'stop'

if ([string]::IsNullOrEmpty($sessionCookie)) {
    Write-Error "Please save the value of the 'session' cookie from your browser and store it in a file named 'Cookie' in this directory. More info in the comments of this script."
}

$date = Get-Date
$year = $date.Year
$day = $date.Day
$month = $date.Month
$fileTemplate = @'
# example input
$in = @"
"@

# puzzle input
# Get-Content -Path .\input.txt

'@


#region functions
function TryGrabAndSaveInput {
    param(
        $Year,
        $Day
    )

    $fileName = GetDayPath -Day $Day -FileName "input.txt"

    if (Test-Path $fileName) {
        if (-not [string]::IsNullOrEmpty((Get-Content $fileName))) {
            Write-Host "Found puzzle input in file for day '$day', no need to grab from url."
            return
        }
    }

    $uri = "http://adventofcode.com/$year/day/$day/input"
    try {
        $in = Invoke-RestMethod -Uri $uri -Headers @{cookie = "session=$sessionCookie"} -ErrorAction stop
        $null = Set-Content -Path $fileName -value $in -ErrorAction stop
        Write-Host "Grabbed puzzle input for day '$day' from url."
    }
    catch {
        Write-Error "Unable to grab and save puzzle input for day '$day' of '$Year'. Error message: `n$($_.Exception.Message)"
    }
}

function GetDayPath {
    param(
        $Day,
        $FileName
    )

    $path = Join-Path -Path $pwd -ChildPath "day$day"
    if ($FileName) {
        Join-Path -Path $path -ChildPath $FileName
    }
    else {
        $path
    }
}

function Setup {
    for ($i = 1; $i -le 25; $i++) {
        $day = "day$i"

        $folderToCreate = GetDayPath -Day $day
        $null = New-Item -Path $folderToCreate -ItemType Directory -ErrorAction SilentlyContinue

        "$day-1.ps1", "$day-2.ps1", "input.txt" | 
            ForEach-Object { 
                $filePath = GetDayPath -Day $day -FileName $_
                $null = New-Item -Path $filePath -ItemType File -ErrorAction SilentlyContinue
            }

        $puzzle1script = GetDayPath -Day $day -FileName 'input.txt'
        $fileContent = Get-Content $puzzle1script

        if ([string]::IsNullOrEmpty($fileContent)) {
            $null = Set-Content -Path $puzzle1script -Value $fileTemplate
        }
    }
}

#endregion functions

if ($month -lt 12) {
    $year = $year -1
    $days = 1..25
    Write-Warning "Fetching puzzle input for last year: $year."
}
else {
    $days = 1..$day
    Write-Host "Fetching puzzle input for $year."
}

$parentDirectoryName = (Split-Path $pwd -Leaf)
if ($parentDirectoryName -notmatch "^adventofcode$year$") {
    Write-Error "Parent dir must be named 'adventofcode$year'."
}

if (-not (Test-Path (GetInputFileName -Day 25))) {
    Setup
}

foreach ($d in $days) {
    TryGrabAndSaveInput -year $year -Day $d
}





