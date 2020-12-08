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
    param(
        $program,
        $indexToSwap
    )

    $accumulator = 0
    $history = New-Object system.collections.arraylist

    for ($i = 0; $history -notcontains $i; ) {
        $null = $history.add($i)

        $instr = $program[$i].instruction
        $amount = $program[$i].amount

        if ($i -eq $indexToSwap) {
            $instr = swapInstruction -instruction $instr
        }

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
            Default {write-warning "unknown instruction $instr"}
        }

        if ($i -eq $program.Length) {
            return $accumulator
        }
        if ($i -gt $program.Length) {
            return $null
        }
    }
    return $null
}

function swapInstruction {
    param($instruction)

    switch ($instruction) {
        nop {return 'jmp'}
        jmp {return 'nop'}
        default {Write-warning "unknown instrution $instruction"}
    }
}

function getIndexesToSwap {
    param($program)

    $indices = New-Object system.collections.arraylist

    for ($i = 0; $i -lt $program.Length; $i++) {
        $instr = $program[$i].instruction
        if ($instr -eq 'nop' -or $instr -eq 'jmp' ) {
            $indices.add($i)
        }
    }

    return $indices
}

function tryFixProgram {
    param(
        $indices,
        $program
    )

    for($i = 0; $i -lt $indices.Length; $i++) {
        $accumulator = runProgram -program $program -indexToSwap $indices[$i]
        if ($null -ne $accumulator) {
            return $accumulator
        }
    } 
}


$program = readinput -in $in

$indices = getIndexesToSwap -program $program

tryFixProgram -indices $indices -program $program