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

function adjustHeading {
    param(
        [heading]$Heading,
        [Instruction]$Instruction
    )

    $val = $Instruction.Value

    if ($Instruction.Action -eq 'R') {
        $val = 360 - $val
    }

    $head = $Heading.value__ + $val
    $heading = [heading]($head % 360)

    return $heading
}

function getManhattanDistance {
    param([position]$position) 
    
    return [math]::Abs($position.x) + [math]::Abs($position.y)
}

function moveShip {
    param(
        [Heading]$heading,
        [int]$distance,
        [Position]$position
    )

    switch ($heading) {
        'North' {
            $position.y += $distance
        }
        'South' {
            $position.y -= $distance
        }
        'East' {
            $position.x += $distance
        }
        'West' {
            $position.x -= $distance
        }
    }

    return $position
}

function handleInstructions {
    param(
        [Instruction[]]$instructions, 
        [position]$position,
        [heading]$heading
    )

    foreach ($instruction in $instructions) {
        switch ($instruction.Action) {
            'F' {
                $position = moveShip -heading $heading -distance $instruction.Value -position $position
            }
            'L' {
                $heading = adjustHeading -heading $heading -instruction $instruction 
            }
            'R' {
                $heading = adjustHeading -heading $heading -instruction $instruction
            }
            'N' {
                $position = moveShip -heading 'North' -distance $instruction.value -position $position
            }
            'S' {
                $position = moveShip -heading 'South' -distance $instruction.value -position $position
            }
            'E' {
                $position = moveShip -heading 'East' -distance $instruction.value -position $position
            }
            'W' {
                $position = moveShip -heading 'West' -distance $instruction.value -position $position
            }
        }

        #Write-Host $instruction.action, "`t", $instruction.value, "`t", $heading, "`t", $position.x, "`t", $position.y
    }

    return $position
} 


[Position]$position = [position]@{x = 0; y = 0 } 
[heading]$heading = 'East' 

$instructions = readinput -in $in

$position = handleInstructions -instructions $instructions -position $position -heading $heading

getManhattanDistance -position $position
