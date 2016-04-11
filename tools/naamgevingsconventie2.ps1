Function Get-MDSLogin {

param(
[string]$Voornaam,
[string]$Achternaam

)


#$voornaam = 'Marie'
#$lastname = 'Pieters'
$voornaam_kort = $Voornaam.Substring(0,1)
$inlog =$voornaam_kort + $Achternaam
$inlog.ToLower()
 

}

Get-MDSLogin -Achternaam "Harrie"
