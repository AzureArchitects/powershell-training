Function Get-MDSLogin {

param(

[Parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
[string]$GivenName,

[Parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
[string]$SurName

)


Process {
    $voornaam_kort = $GivenName.Substring(0,1)
    $inlog =$voornaam_kort + $SurName
    $inlog.ToLower()
 }

}

Get-AdUser -Filter * |  Get-MDSLogin 