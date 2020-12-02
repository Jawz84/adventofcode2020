[int[]]$in = Get-Content .\input.txt

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