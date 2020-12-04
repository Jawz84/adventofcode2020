# http://adventofcode.com/2020/day/4 

# example input
$in = Get-Content -Path .\exampleinput.txt -Raw

# puzzle input
$in = Get-Content -Path .\input.txt -Raw

$expectedFields = @(
    'byr'
    'iyr'
    'eyr'
    'hgt'
    'hcl'
    'ecl'
    'pid'
    'cid'
)

function getPassports {
    param($in)

    $in = $in.Replace("`n`n", ";").Replace("`n"," ")

    $in.Split(";") | Foreach-Object {
        $p = @{}
        $_.Split(" ") | ForEach-Object {
            $t = $_.Split(":")
            $p.Add($t[0], $t[1])
        }
        $p
    }
}

function checkPassports {
    param($passports)

    foreach ($p in $passports) {
        $missingFields = @($expectedFields.Where( {$p.Keys -notcontains $_}))
        if ($missingFields.Count -eq 0) {
            1
        }
        elseif( $missingFields.Count -eq 1 -and $missingFields -eq 'cid') {
            1
        }
    }

}

$passports = getPassports -in $in

(checkPassports -passports $passports).Count