# http://adventofcode.com/2020/day/8 

# example input
$in = Get-Content -Path .\exampleinput.txt

# puzzle input
$in = Get-Content -Path .\input.txt

function readInput {
    param($in) 

    foreach ($i in $in | Where-Object {$_ -notlike ""}) {
        $instruction, $amount = $i.split(' ')
        [pscustomobject]@{
            instruction = $instruction
            amount      = $amount
        }
    }
}

function runProgram {
    param($program)

    $accumulator = 0
    $history = New-Object system.collections.arraylist

    for ($i = 0; $history -notcontains $i; ) {
        $null = $history.add($i)
        $instr = $program[$i].instruction
        $amount = $program[$i].amount

        switch ($instr) {
            nop {
                $i++
            }
            acc {
                $accumulator += (Invoke-expression $amount)
                $i++
            }
            jmp {
                $i += (Invoke-expression $amount)
                
            }
            Default {write-warning "unknown instruction $_"}
        }
    }
    return $accumulator
}

$program = readinput -in $in

runProgram -program $program