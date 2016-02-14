function Get-Login {


    $firstname = 'Satya'
    $lastname = 'Nadella'
    $firstshort = $firstname.substring(0,3)
    $lastshort = $lastname.substring(0,3)
    $logon = $firstshort+$lastshort
    $sam = $logon.tolower()
    $date = (Get-Date -format 'yyyyMMdd')

    Write-Host "$sam in dienst op $date"
 }

Get-Login