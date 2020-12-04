# http://adventofcode.com/2020/day/4 

# example input
$in = Get-Content -Path .\exampleinput2.txt -Raw

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
    [cmdletbinding()]
    param($passports)

    foreach ($p in $passports) {
        if (-not (isValid -Passport $p -Verbose )) {
            continue
        }

        $missingFields = @($expectedFields.Where( {$p.Keys -notcontains $_}))
        if ($missingFields.Count -eq 0) {
            1
        }
        elseif( $missingFields.Count -eq 1 -and $missingFields -eq 'cid') {
            1
        }
    }
}

<#
Validation

byr (Birth Year) - four digits; at least 1920 and at most 2002.
iyr (Issue Year) - four digits; at least 2010 and at most 2020.
eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
hgt (Height) - a number followed by either cm or in:
If cm, the number must be at least 150 and at most 193.
If in, the number must be at least 59 and at most 76.
hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
pid (Passport ID) - a nine-digit number, including leading zeroes.
cid (Country ID) - ignored, missing or not.

#>

function isValid {
    [cmdletbinding()]
    param($passport)

    try {
        if ($passport.byr -notmatch "^\d{4}$" -or $passport.byr -lt 1920 -or $passport.byr -gt 2002) { return $false }
        if ($passport.iyr -notmatch "^\d{4}$" -or $passport.iyr -lt 2010 -or $passport.iyr -gt 2020) { return $false }
        if ($passport.eyr -notmatch "^\d{4}$" -or $passport.eyr -lt 2020 -or $passport.eyr -gt 2030) { return $false }
        if ($passport.hgt -notmatch "^(1([5-8]\d|9[0-3])cm|(59|6\d|7[0-6])in)$" ) { return $false }
        if ($passport.hcl -notmatch "^#[0-9a-f]{6}$") { return $false }
        if ($passport.ecl -notmatch "^(amb|blu|brn|gry|grn|hzl|oth)$") { return $false }
        if ($passport.pid -notmatch "^\d{9}$") { return $false }
    }
    catch {
        Write-Verbose $_.Exception.Message
        return $false
    }

    return $true
}


$passports = getPassports -in $in

(checkPassports -passports $passports -Verbose).Count