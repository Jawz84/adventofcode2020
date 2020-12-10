# http://adventofcode.com/2020/day/10 

# example input
$in = (Get-Content -Path .\exampleinput.txt | Where-Object { $_ -notlike "" }) -as [int[]]
$in = (Get-Content -Path .\exampleinput2.txt | Where-Object { $_ -notlike "" }) -as [int[]]

# puzzle input
$in = (Get-Content -Path .\input.txt | Where-Object { $_ -notlike "" }) -as [int[]]

$sortedIn = ($in | Sort-Object ) -as [System.Collections.ArrayList] 

$sortedIn | Out-File .\inputSorted.txt
$null = $sortedIn.Insert(0, 0)
$null = $sortedIn.Add($sortedIn[-1] + 3)

function getContiguousAdapters {
    param ($sortedIn)

    $contigList = New-Object system.collections.arraylist

    $sum = 0

    for ($i = 0; $i -lt $sortedIn.Count - 1; $i++) {
        $diff = $sortedIn[$i + 1] - $sortedIn[$i]

        switch ($diff) {
            1 {
                $sum++
            }
            3 {
                $null = $contigList.Add($sum)
                $sum = 0
            }
        } 
    }

    return $contigList
}

function calculatePermuations {
    param($contigList)

    [long]$permutations = 1

    foreach ($item in $contigList) {
        
        switch ($item) {
            0 {}
            1 {}
            2 {
                $permutations = $permutations * 2
            }
            3 {
                $permutations = $permutations * 4
            }
            4{
                $permutations = $permutations * 7
            }
        }
    }
    return $permutations
}


$contigList = getContiguousAdapters -sortedIn $sortedIn

calculatePermuations -contigList $contigList