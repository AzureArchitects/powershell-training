Function Get-MDSLogin {

$voornaam = 'Marie'
$lastname = 'Pieters'
$voornaam_kort = $voornaam.Substring(0,1)
$inlog =$voornaam_kort + $lastname
$inlog.ToLower()

}

Get-MDSLogin