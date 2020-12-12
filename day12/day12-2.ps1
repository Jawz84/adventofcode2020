# http://adventofcode.com/2020/day/12 

# example input
$in = Get-Content -Path .\exampleinput.txt | Where-Object { $_ -notlike "" }

# puzzle input
$in = Get-Content -Path .\input.txt | Where-Object { $_ -notlike "" }

enum heading {
    North = 0
    West = 90
    South = 180
    East = 270
}

class Instruction {
    [char]$Action
    [int]$Value
}

class Position {
    [int]$x
    [int]$y
}

function readinput {
    param($in)

    foreach ($i in $in) {
        $null = $i -match "^(?'act'\w)(?'val'\d+)$"
        [instruction]@{
            Action = [char]$Matches.act
            Value  = $Matches.val
        }
    }
}

#$waypoint = rotateWaypoint -waypoint $waypoint -instruction $instruction 
function rotateWaypoint {
    param(
        [position]$waypoint,
        [Instruction]$Instruction
    )

    $x = $waypoint.x
    $y = $waypoint.y

    $val = $Instruction.Value

    if ($Instruction.Action -eq 'R') {
        $val = 360 - $val
    }

    switch ($val) {
        90 {
            $waypoint.x = - $y
            $waypoint.y = $x 
        }
        180 {
            $waypoint.x = - $x
            $waypoint.y = - $y
        }
        270 {
            $waypoint.x = $y
            $waypoint.y = - $x
        }
    }

    return $waypoint
}

function getManhattanDistance {
    param([position]$position) 
    
    return [math]::Abs($position.x) + [math]::Abs($position.y)
}

# $position = moveShip -waypoint $waypoint -distance $instruction.Value -position $position
function moveShip {
    param(
        [position]$waypoint,
        [int]$distance,
        [Position]$position
    )

    $position.x += $waypoint.x * $distance
    $position.y += $waypoint.y * $distance

    return $position
}

function moveWaypoint {
    param(
        [heading]$heading,
        [position]$waypoint,
        [int]$distance
    )

    switch ($heading) {
        'North' {
            $waypoint.y += $distance
        }
        'South' {
            $waypoint.y -= $distance
        }
        'East' {
            $waypoint.x += $distance
        }
        'West' {
            $waypoint.x -= $distance
        }
    }

    return $waypoint
}

function handleInstructions {
    param(
        [Instruction[]]$instructions, 
        [position]$position,
        [position]$waypoint
    )

    foreach ($instruction in $instructions) {
        switch ($instruction.Action) {
            'F' {
                $position = moveShip -waypoint $waypoint -distance $instruction.Value -position $position
            }
            'L' {
                $waypoint = rotateWaypoint -waypoint $waypoint -instruction $instruction 
            }
            'R' {
                $waypoint = rotateWaypoint -waypoint $waypoint -instruction $instruction
            }
            'N' {
                $waypoint = moveWaypoint -waypoint $waypoint -heading 'North' -distance $instruction.value 
            }
            'S' {
                $waypoint = moveWaypoint -waypoint $waypoint -heading 'South' -distance $instruction.value 
            }
            'E' {
                $waypoint = moveWaypoint -waypoint $waypoint -heading 'East' -distance $instruction.value 
            }
            'W' {
                $waypoint = moveWaypoint -waypoint $waypoint -heading 'West' -distance $instruction.value
            }
        }

        #Write-Host $instruction.action, "`t", $instruction.value, "`t", $heading, "`t", $position.x, "`t", $position.y
    }

    return $position
} 


[Position]$position = [position]@{x = 0; y = 0 } 
[position]$waypoint = [position]@{x = 10; y = 1 }

$instructions = readinput -in $in

$position = handleInstructions -instructions $instructions -position $position -waypoint $waypoint

getManhattanDistance -position $position
