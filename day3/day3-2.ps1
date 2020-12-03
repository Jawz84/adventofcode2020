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

    for ($y = $down; $y -lt $height; $y = $y + $down) {

        $x = $x + $right
        $wrappedX = $x % $width
        $char = $map[$y][($wrappedX)]
        
        write-verbose "$y, $x ($wrappedX) `t: $char"
        
        if ($char -eq '#') {
            1
        }
    }
}

$map = readinput -in $in

($a = (rideTobbogan -right 1 -down 1 -map $map).count)
($b = (rideTobbogan -right 3 -down 1 -map $map).count)
($c = (rideTobbogan -right 5 -down 1 -map $map).count)
($d = (rideTobbogan -right 7 -down 1 -map $map).count)
($e = (rideTobbogan -right 1 -down 2 -map $map).count)

# 2711882160 too low
$a*$b*$c*$d*$e