# http://adventofcode.com/2020/day/9 

# example input
[double[]]$in = Get-Content -Path .\exampleinput.txt

# puzzle input
[double[]]$in = Get-Content -Path .\input.txt

#$magicNumber = 127
$magicNumber = [double](.\day9-1.ps1)[0].trim()

function findContiguousSum  {
    param(
        $target,
        [double[]]$in
    )

    return ($in | Measure-Object -Sum ).Sum -eq $target

}

for ($i = 0; $i -lt $in.Length -2; $i++) {
    for ($preAmbleLength = 2; $preAmbleLength -lt $in.Length - $pos; $preAmbleLength++ ) {
        $currentPreamble = $in | 
            Select-Object -First $preAmbleLength -Skip $i
        if (($currentPreamble | Measure-Object -sum).sum -gt $magicNumber) {
            break
        }

        $isOK = findContiguousSum -target $magicNumber -in $currentPreamble
        if ($isOK) {
            $sort = $currentPreamble | sort 
            [double]$highest = $sort | select -first 1
            [double]$lowest = $sort | select -last 1
            $highest + $lowest
        }
    }
}

# if you've read this far.. this is my ugliest solution so far. And it is slooow. But I'm leaving it as-is, because so far, I have 
# pushed all my solutions without any real cleanup.
# I wonder what day 25 is going to look like heheh. 