Function Get-MDSLogin {

param(

[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
[string]$Voornaam,

[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
[string]$Achternaam

)


Process {
    $voornaam_kort = $Voornaam.Substring(0,1)
    $inlog =$voornaam_kort + $Achternaam
    $inlog.ToLower()
 }

}

Import-csv .\import.csv |  Get-MDSLogin 