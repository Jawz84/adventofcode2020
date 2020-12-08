# http://adventofcode.com/2020/day/7 

# example input
$in = Get-Content -Path .\exampleinput.txt
$in = Get-Content -Path .\exampleinput2.txt

# puzzle input
$in = Get-Content -Path .\input.txt

function readInput {
    param($in)

    $out = @{}
    foreach ($rule in $in) {
        $res = ($rule -split "bags?,?" -replace "contain", "" | Where-Object {$_ -ne '.'} ).Trim()
        $contents = $res | Select-Object -Skip 1 | Where-Object {$_ -notmatch "no other"}

        $contents = $contents | ForEach-Object {
            $t = $_ -split "(\d+)"
            [PSCustomObject]@{
                Name = $t[2].trim()
                Amount = [int]$t[1].trim()
            }
        }

        if ($null -ne $contents) {
            $out.add($res[0], $contents)
        }
    }
    return $out
}


function getNestedBags {
    param(
        $name,
        $rules
    )

    if (-not $rules.ContainsKey($name)) {
        return 0
    }
    
    $sum = 0
    foreach ($contents in $rules["$name"]) {
        $nestedBagsCount = getNestedBags -name $contents.Name -rules $rules
        $sum += $contents.Amount + $nestedBagsCount * $contents.Amount
    }
    return $sum 
} 

$rules = readInput -in $in 

getNestedBags -name 'shiny gold' -rules $rules
