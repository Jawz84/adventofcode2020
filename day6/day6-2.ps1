# http://adventofcode.com/2020/day/6 

# example input
$in = Get-Content -Path .\exampleinput.txt

# puzzle input
$in = Get-Content -Path .\input.txt

function readGroups {
    param($in)

    $group = 0

    foreach ($person in $in) {
        if ($person -eq "") {
            $group++
            continue
        }

        [PSCustomObject]@{
            GroupNr = $group
            Answers = $person.ToCharArray() | Sort-Object -Unique
        }
    }
}

function getUniqueAnswersPerGroup {
    param($groups)

    $group = $groups | Group-Object -Property GroupNr

    foreach ($g in $group) {
        $intersection = $g.Group[0].Answers

        for ($i=1; $i -lt $g.Group.Count; $i++) {
            $intersection = intersect -set1 $intersection -set2 $g.Group[$i].Answers
        }

        [PSCustomObject]@{
            Group = $g.Name
            Amount = $intersection.length
        }
    }
}

function intersect {
    param(
        $set1,
        $set2
    )
    
    return $set1 | Where-Object { $set2 -contains $_ }
}


$groups = readGroups -in $in 

getUniqueAnswersPerGroup -groups $groups | Measure-Object -property amount -sum | select -ExpandProperty sum