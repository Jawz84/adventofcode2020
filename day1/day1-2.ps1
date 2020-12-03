# http://adventofcode.com/2020/day/1

# example input
$in = Get-Content -Path .\exampleinput.txt

# puzzle input
$in = Get-Content -Path .\input.txt


[int[]]$in = $in

$correct = 2020

for($i = 0; $i -lt $in.Length; $i++) {
    for ($j = $i+1; $j -lt $in.Length; $j++) {
        for ($k = $j+1; $k -lt $in.Length; $k++) {
            $sum = $in[$i] + $in[$j] + $in[$k]
            if ($sum -eq $correct) {
                (($in[$i]) * ($in[$j]) * ($in[$k]))
                break
            }
        }
        if ($sum -eq $correct) {
            break
        }
    }
    if ($sum -eq $correct) {
        break
    }
}