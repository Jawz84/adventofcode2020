# http://adventofcode.com/2020/day/13 

# example input
$in = Get-Content -Path .\exampleinput2.txt

# puzzle input
$in = Get-Content -Path .\input.txt

#$time = $in[0] 
#$ids = [long[]]($in[1].split(',').replace('x', '0'))
         
#100000000000000
#102514535828682


for ($i =186802119228.0 ;; $i++) {
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
        $a; break
    }
}