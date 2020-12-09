# http://adventofcode.com/2020/day/9 

# example input
$in = Get-Content -Path .\exampleinput.txt

# puzzle input
$in = Get-Content -Path .\input.txt

function checkSum {
    
    param(
        [long[]]$in,
        $target
    )

    for ($i = 0; $i -lt $in.Length; $i++) {
        for ($j = $i + 1; $j -lt $in.Length; $j++) {
            $sum = $in[$i] + $in[$j]
            if ($sum -eq $target -and $in[$i] -ne $in[$j] ) {
                return $true
            }
        }
    }
    return $false
}


$preAmbleLength = 25
for ($i = $preAmbleLength; $i -lt $in.Length; $i++) {
    $currentPreamble = $in | 
        Select-Object -First $preAmbleLength -Skip ($i - $preAmbleLength)
    $isOK = checkSum -target $in[$i] -in $currentPreamble
    if (-not $isOK) {
        $in[$i]
    }
}
    
