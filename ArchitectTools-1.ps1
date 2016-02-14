function Get-LoginInfo 

{
    
    $firstname = 'Satya'
    $lastname = 'Nadella'
    $firstshort = $firstname.substring(0,3)
    $lastshort = $lastname.substring(0,3)
    $logon = $firstshort+$lastshort
    $new = $logon.tolower()
    $date = (Get-Date -format 'yyyyMMdd')

    Write-Host "$new en dienst op $date"
}

Get-LoginInfo