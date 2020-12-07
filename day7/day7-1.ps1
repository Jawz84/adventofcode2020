# http://adventofcode.com/2020/day/7 

# example input
$in = Get-Content -Path .\exampleinput.txt

# puzzle input
$in = Get-Content -Path .\input.txt

function readInput {
    param($in)

    foreach ($rule in $in) {
        $res = ($rule -split "bags?,?" -replace "contain", "" | Where-Object {$_ -ne '.'} ).Trim()
        $contents = $res | Select-Object -Skip 1 | Where-Object {$_ -notmatch "no other"}

        $contents = $contents | ForEach-Object {
            $t = $_ -split "(\d+)"
            [PSCustomObject]@{
                Name = $t[2].trim()
                Amount = $t[1].trim()
            }
        }

        [PSCustomObject]@{
            Name     = $res[0]
            contents = $contents
        }
    }
}

function findNested {
    param(
        $rules,
        $target
    )

    $rule = $rules | Where-Object {$_.contents.Name -contains $target} 

    foreach ($name in $rule.Name) {
        $name
        findNested -rules $rules -target $name
    }
}


$rules = readInput -in $in

(findNested -rules $rules -target 'shiny gold' | Sort-Object -Unique).Length