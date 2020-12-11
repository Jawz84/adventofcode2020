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

function getChairInDirection {
    param($x, $y, $dirx, $diry, $grid)

    $x = $x + $dirx
    $y = $y + $diry
    if ($y -lt 0 -or $x -lt 0 -or $y -ge $grid.count -or $x -gt $grid[0].count ) {
        return '.'
    }

    $chair = $grid[$y][$x]

    if ($chair -eq '.') {
        $chair = getChairInDirection -x $x -y $y -dirx $dirx -diry $diry -grid $grid
    }

    return $chair
}

function getOccupiedAdjacent {
    param($x, $y, $grid) 

    # diagonal up left
    $count += if ((getChairInDirection -y $y -diry -1 -x $x -dirx -1 -grid $grid) -eq '#') {
        1
    }
    else {
        0
    }  
    
    # up 
    $count += if ((getChairInDirection -y $y -diry -1 -x $x -dirx 0 -grid $grid) -eq '#') {
        1
    }
    else {
        0
    } 
    
    # diagonal up right 
    $count += if ((getChairInDirection -y $y -diry -1 -x $x -dirx 1 -grid $grid)  -eq '#') {
        1
    }
    else {
        0
    }  
    
    # left
    $count += if ((getChairInDirection -y $y -diry 0 -x $x -dirx -1 -grid $grid) -eq '#') {
        1
    }
    else {
        0
    }  
    
    # right
    $count += if ((getChairInDirection -y $y -diry 0 -x $x -dirx 1 -grid $grid) -eq '#') {
        1
    }
    else {
        0
    }  
    
    # diagonal down left
    $count += if ((getChairInDirection -y $y -diry 1 -x $x -dirx -1 -grid $grid) -eq '#') {
        1
    }
    else {
        0
    }  
    
    # down
    $count += if ((getChairInDirection -y $y -diry 1 -x $x -dirx 0 -grid $grid) -eq '#') {
        1
    }
    else {
        0
    }  
    $count += if ((getChairInDirection -y $y -diry 1 -x $x -dirx 1 -grid $grid) -eq '#') {
        1
    }
    else {
        0
    }  

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
                    if ($occupiedAdjacent -ge 5) {
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

