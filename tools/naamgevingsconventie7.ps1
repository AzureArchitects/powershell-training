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
    write-output $inlog.ToLower()
 }

}

<#
Get-AdUser -Filter * |  Get-MDSLogin 
#>

function Set-MDSLoginName {


  #[CmdletBinding()]
  param(
      
    [Parameter(
        Position=0, 
        Mandatory=$true, 
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true
      )
    ]
    [string]$Path
    
   
  )
     
  Process {
        
      $users = Get-ADUser -Filter * -SearchBase $Path  -Properties * 
     
      Foreach ($user in $users) {
      
        #niet via pipeline
        try {
        $newSam = Get-MDSLogin -GivenName $user.GivenName -SurName $user.Surname  
        $newUPN = $newSam + '@mds.local'
        #Write-Host "nieuw: $newSam $newUPN"
        Set-AdUser $user -SamAccountName $newSam -UserPrincipalName $newUPN
         } catch {
        
        Write-Host "Errors with $user :"  
        Write-Host $_.Exception.message

       }
      }
     }
  
}

$path = 'OU=NL,DC=mds,DC=local'
$path | Set-MDSLoginName




