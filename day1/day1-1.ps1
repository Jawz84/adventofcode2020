[int[]]$in = Get-Content .\input.txt

$correct = 2020

for($i = 0; $i -lt $in.Length; $i++) {
    for ($j = $i+1; $j -lt $in.Length; $j++) {
            $sum = $in[$i] + $in[$j]
            if ($sum -eq $correct) {
                ($in[$i]) * ($in[$j])
                break
            }
    }
    if ($sum -eq $correct) {
        break
    }
}