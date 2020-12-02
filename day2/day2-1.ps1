$in = gc .\input.txt

function parse {
    param(
        [string[]] $in
    )
    foreach ($i in $in) {
        [pscustomobject]@{
            atLeast = [int]($i.Split("-")[0])
            atMost = [int]($i.Split("-")[1].Split(" ")[0])
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
        $count = @($i.password.ToCharArray() -eq $i.letter).Length
        if ($count -ge $i.atLeast -and $count -le $i.atMost) {
            1
        }
    }
}

$parsedIn = parse -in $in
(isValid -in $parsedIn).Count

