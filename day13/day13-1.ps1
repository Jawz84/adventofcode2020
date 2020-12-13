# http://adventofcode.com/2020/day/13 

# example input
$in = Get-Content -Path .\exampleinput.txt

# puzzle input
$in = Get-Content -Path .\input.txt

$time = $in[0] 
$ids = $in[1].split(',') | Where-Object { $_ -ne "x" }

function findFirstDeparture {
    param(
        $departAfter, 
        $id
    )
    $id - ($departAfter % $id)
}

function findFirstBus {
    param(
        $ids,
        $time
    )

    foreach ($id in $ids) {
        [pscustomobject]@{
            departsIn = findFirstDeparture -departAfter $time -id $id
            busId     = $id
        }
    } 
}


$res = findFirstBus -ids $ids -time $time | Sort-Object departsIn | Select-Object -First 1 

[double]$res.busid * [double]$res.departsIn
