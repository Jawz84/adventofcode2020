$in = gc .\input.txt

function parse {
    param(
        [string[]] $in
    )
    foreach ($i in $in) {
        [pscustomobject]@{
            pos1 = [int]($i.Split("-")[0]) - 1
            pos2 = [int]($i.Split("-")[1].Split(" ")[0]) - 1
            letter = $i.Split(" ")[1][0]
            password = $i.Split(":")[1].Trim()
        }
    }
}

function isValid {
    param(
        [pscustomobject[]]$in
    )

    foreach ($i in $in) {
        if ($i.password[$i.pos1] -eq $i.letter -xor $i.password[$i.pos2] -eq $i.letter) {
            1
        }
    }
}

$parsedIn = parse -in $in
(isValid -in $parsedIn).Count

