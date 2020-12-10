# http://adventofcode.com/2020/day/10 

# example input
$in = (Get-Content -Path .\exampleinput.txt | where { $_ -notlike ""}) -as [int[]]
$in = (Get-Content -Path .\exampleinput2.txt | where { $_ -notlike ""}) -as [int[]]

# puzzle input
$in = (Get-Content -Path .\input.txt | where { $_ -notlike ""}) -as [int[]]

$sortedIn = ($in | sort ) -as [System.Collections.ArrayList] 

$null = $sortedIn.Insert(0, 0)
$null = $sortedIn.Add($sortedIn[-1] + 3)

$one = 0
$three = 0 

for ($i = 0; $i -lt $sortedIn.Count-1; $i++) {
    $diff = $sortedIn[$i+1] - $sortedIn[$i]

    switch ($diff) {
        1 {
            $one++
        }
        3 {
            $three++
        }
    } 
}

[PSCustomObject]@{
    one = $one
    three = $three
    product = $one * $three
}
