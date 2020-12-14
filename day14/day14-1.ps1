# http://adventofcode.com/2020/day/14 

# example input
$in = Get-Content -Path .\exampleinput.txt

# puzzle input
$in = Get-Content -Path .\input.txt

$in = $in | Where-Object { $_ -notlike "" }


function toPaddedBinary {
    param([double]$num)

    $bin = [convert]::ToString($num, 2)
    return '0' * (36 - $bin.Length) + $bin
}

$mem = @{}

foreach ($i in $in) {
    if ($i -match "mask = (?'mask'\S+)") {
        $mask = $matches.mask
    }
    if ($i -match "mem\[(?'address'\d+)\] = (?'value'\d+)") {
        $address = $matches.address
        $value = $matches.value

        $valueLong = toPaddedBinary $value

        Write-Verbose $mask
        Write-Verbose $valueLong

        [double]$sum = 0.0
        for ($i = 0; $i -lt 36; $i++ ) { 

            if ($mask[$i] -eq '1') {
                $sum += [Math]::Pow(2, 35 - $i)
            }
            elseif ($mask[$i] -ne '0' -and $valueLong[$i] -eq '1') {
                $sum += [Math]::Pow(2, 35 - $i) 
            }
            
            $longSum = toPaddedBinary $sum
            if ($longSum -ne "000000000000000000000000000000000000") {
                Write-Verbose $longSum
            }
        }
        $mem.$address = $sum
    }
}

[double]$sum = 0.0
$mem.Values | ForEach-Object { $sum += $_ }
$sum
