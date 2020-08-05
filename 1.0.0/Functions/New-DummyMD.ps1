Function Make-DummyMD {
    Param(
        [int]$Number = 1
    )

    foreach($i in (1..$Number)){
        Write-Host ("{0,6:d6}" -f $i)
    }
}