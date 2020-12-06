# http://adventofcode.com/2020/day/6 

# example input
$in = Get-Content -Path .\exampleinput.txt

# puzzle input
$in = Get-Content -Path .\input.txt

function readGroups {
    param($in)
    $group = 0
    $answers = [System.Collections.ArrayList]@{}
    foreach ($person in $in) {
        if ($person -eq "") {
            [PSCustomObject]@{
                GroupNr = $group
                Answers = $answers
            }
            $group++
            $answers = [System.Collections.ArrayList]@{}
            continue
        }
        $answers.AddRange($person.ToCharArray())
    }
}

function getUniqueAnswersPerGroup {
    param($groups)

    foreach ($g in $groups) {
        [PSCustomObject]@{
            GroupNr = $g.GroupNr
            UniqueAnswers = ($g.Answers | Sort-Object -Unique).Count
        }
    }
}

$groups = readGroups -in $in 

getUniqueAnswersPerGroup -groups $groups | Measure-Object -Property UniqueAnswers -Sum | select -ExpandProperty Sum