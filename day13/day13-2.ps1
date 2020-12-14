# http://adventofcode.com/2020/day/13 

# example input
#$in = Get-Content -Path .\exampleinput.txt

# puzzle input
#$in = Get-Content -Path .\input.txt


# This is the way I eventually did find a solution, by brute forcing in sets in parrallel. 
# This set came up with the correct answer:
# It is completely tailored to my puzzle input and would need to be adjusted for other puzzle inputs.

for ($i = 1000000000000.0 ;$i -lt 1100000000000.0; $i++) {
    $a = 557.0 * $i
    if (
        (($a+31) % 419 -eq 0) -and
        (($a-41) % 41 -eq 0 ) -and
        (($a-6) % 37 -eq 0) -and
        (($a+2) % 29 -eq 0) -and
        (($a+23) % 23 -eq 0) -and
        (($a+50) % 19 -eq 0) -and
        (($a+17) % 17 -eq 0) -and
        (($a+13) % 13 -eq 0)
    ) {
        $a-41; break
    }
}
# = 598411311431841


# This isn't mine. I don't really understand why it works. Leaving it like this to study another time.

$null, $timetable = (gc .\input.txt| Where-Object {$_ -notlike ""}) -split ','

$timestamp = 0l
$increment = $timetable[0] -as [long]
for ($i = 1; $i -lt $timetable.Count; $i++) {
    if ($timetable[$i] -ne 'x') {
        $newTime = $timetable[$i] -as [long]
        while ($true) {
            $timestamp += $increment
            if (($timestamp + $i) % $newTime -eq 0) {
                $increment *= $newTime
                break
            }
        }
    }
}
$timestamp

