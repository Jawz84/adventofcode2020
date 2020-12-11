# http://adventofcode.com/2020/day/11 

# example input
$in = Get-Content -Path .\exampleinput.txt

# puzzle input
$in = Get-Content -Path .\input.txt

function getGrid {
    param($in)

    $grid = New-Object 'System.Collections.Generic.List[char[]]'

    foreach ($line in $in | Where-Object { $_ -notlike '' }) {
        $null = $grid.add($line.ToCharArray())
    }

    return $grid
}

function displayGrid {
    param($grid)

    foreach ($i in $grid) {
        Write-Host (-join $i)
    }
}

function getOccupiedAdjacent {
    param($x, $y, $grid) 

    $ErrorActionPreference = 'silentlycontinue'
    
    $count += if ($y -ne 0 -and $x -ne 0 -and $grid[$y - 1][$x - 1] -eq '#') {
        1
    }
    else {
        0
    }  
    $count += if ($y -ne 0 -and $grid[$y - 1][$x] -eq '#') {
        1
    }
    else {
        0
    }  
    $count += if ($y -ne 0 -and $grid[$y - 1][$x + 1] -eq '#') {
        1
    }
    else {
        0
    }  
    
    $count += if ($x -ne 0 -and $grid[$y][$x - 1] -eq '#') {
        1
    }
    else {
        0
    }  
    $count += if ($grid[$y][$x + 1] -eq '#') {
        1
    }
    else {
        0
    }  
    
    $count += if ($x -ne 0 -and $grid[$y + 1][$x - 1] -eq '#') {
        1
    }
    else {
        0
    }  
    $count += if ($grid[$y + 1][$x] -eq '#') {
        1
    }
    else {
        0
    }  
    $count += if ($grid[$y + 1][$x + 1] -eq '#') {
        1
    }
    else {
        0
    }  

    $ErrorActionPreference = 'continue'
    return $count
}

function calcSeatsToChange {
    param($grid)

    $seatsToChange = New-Object System.Collections.ArrayList

    for ($y = 0; $y -lt $grid.Count; $y++) {
        for ($x = 0; $x -lt $grid[0].count; $x++) {
            $currentSeat = $grid[$y][$x] 

            $occupiedAdjacent = getOccupiedAdjacent -x $x -y $y -grid $grid

            switch ($currentSeat) {
                '.' {
                    continue 
                }
                'L' { 
                    if ($occupiedAdjacent -eq 0) {
                        $null = $seatsToChange.add(
                            [PSCustomObject]@{
                                x     = $x
                                y     = $y
                                setTo = '#'
                            }
                        )
                    }
                }
                '#' {
                    if ($occupiedAdjacent -ge 4) {
                        $null = $seatsToChange.add(
                            [PSCustomObject]@{
                                x     = $x
                                y     = $y
                                setTo = 'L'
                            }
                        )                    
                    }
                }
            }
        }
    }

    return $seatsToChange
}

function changeSeats {
    param(
        $grid,
        $seatsToChange
    )

    foreach ($seat in $seatsToChange) {
        $grid[$seat.y][$seat.x] = $seat.setTo
    }

    return $grid
}

function countOccupiedSeats {
    param($grid)

    $count = 0
    foreach ($charArray in $grid) {
        $count +=  ($charArray | Where-Object {$_ -eq '#'} ).count
    }
    return $count
}

$grid = getGrid -in $in

while (1) {
    
    $seatsToChange = calcSeatsToChange -grid $grid
    
    if ($seatsToChange.Count -eq 0)
    {
        break
    }

    $grid = changeSeats -grid $grid -seatsToChange $seatsToChange
}


countOccupiedSeats -grid $grid

