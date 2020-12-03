# http://adventofcode.com/2020/day/3

# example input
$in = Get-Content -Path .\exampleinput.txt

# puzzle input
$in = Get-Content -Path .\input.txt

$right = 3
$down = 1


function readinput {
    param(
        [string[]]$in
    )

    $list = New-Object System.Collections.ArrayList 
    foreach ($i in $in) {
        $null = $list.Add($i.ToCharArray())
    }
    return $list
}

function rideTobbogan {
    param(
        $right, $down, $map
    )

    $height = $map.count 
    $width = $map[0].count

    $x = 0

    for ($y = 1; $y -lt $height; $y = $y + $down) {

        $x = $x + $right
        $wrappedX = $x % $width
        $char = $map[$y][($wrappedX)]
        
        write-host "$y, $x ($wrappedX) `t: $char"
        
        if ($char -eq '#') {
            1
        }
    }
}

$map = readinput -in $in

(rideTobbogan -right $right -down $down -map $map).count
