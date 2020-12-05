# http://adventofcode.com/2020/day/5 

# example input
$in = Get-Content -Path .\exampleinput.txt

# puzzle input
$in = Get-Content -Path .\input.txt

function getSeatID {
    param($row, $column)

    return $row * 8 + $column
}

function getInput {
    param($in)

    foreach ($line in $in) {
        if ($line -like "") {
            continue 
        }

        [pscustomobject]@{
            row    = $line.substring(0, 7)
            column = $line.Substring(7, 3)
        }
    }
}

function decodeBoardingPass {
    param($boardingpasses)

    foreach ($pass in $boardingpasses) {
        $row = decode -topChar 'B' -bottomChar 'F' -string $pass.row
        $column = decode -topChar 'R' -bottomChar 'L' -string $pass.column
        [pscustomobject]@{
            row    = $row
            column = $column
            seatID = getSeatID -row $row -column $column
        }
    }
}

function decode {
    param(
        [char]$topChar,
        [char]$bottomChar,
        [string]$string
    )
    $steps = $string.Length
    $upperBound = [math]::Pow(2, $steps)

    $top = $upperBound
    $bottom = 0
    $chars = $string.ToCharArray()
    for ($i = 0; $i -lt $steps; $i++) {
        if ($chars[$i] -eq $topChar) {
            $bottom = $bottom + ( $top - $bottom ) / 2
        }
        elseif ($chars[$i] -eq $bottomChar) {
            $top = $top - ( $top - $bottom ) / 2
        }
    }
    if ($chars[$i + 1] -eq $topChar) {
        $top
    }
    else {
        $bottom
    }
}

$boardingpasses = getInput -in $in

$decoded = decodeBoardingPass -boardingpasses $boardingpasses

$sorted = $decoded.seatID | Sort-Object -Descending 

(Compare-Object ($sorted[0]..$sorted[-1] ) $decoded.seatID).InputObject