Function Get-MDSLogin {

<#
.SYNOPSIS
Implements the naming convention
.DESCRIPTION
.PARAMETER GivenName
Specifies the GivenName
.PARAMETER SurName
Specifies the SurName
.EXAMPLE
 Get-MDSLogin -GivenName Riet -SurName Dekker
.EXAMPLE
 import-csv test.csv | Get-MDSLogin
#>

  param(

    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [string]$GivenName,

    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [string]$SurName

  )


  Process {
    $voornaam_kort = $GivenName.Substring(0,1)
    $inlog =$voornaam_kort + $SurName
    write-output $inlog.ToLower()
  }

}




Function Add-MDSLogin {

  param(

    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [string]$GivenName,

    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [string]$SurName,

    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [string]$Path
  )


  Process {
        $name = $GivenName + ' ' + $SurName
        $voornaam_kort = $GivenName.Substring(0,1)
        $sam = ($voornaam_kort + $SurName).ToLower()
        $upn = $sam + '@mds.local'
        New-AdUser -Surname $SurName `
          -GivenName $GivenName `
          -Name $name -Display $name `
          -SamAccountName $sam `
          -UserPrincipalName $upn `
          -Path $Path
  }

}




function Set-MDSOULoginName {


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
        $newSam = Get-MDSLogin -GivenName $user.GivenName -SurName $user.Surname  
        $newUPN = $newSam + '@mds.local'
        Write-Host "nieuw: $newSam $newUPN"
        Set-AdUser $user -SamAccountName $newSam -UserPrincipalName $newUPN
       }
     }
  
}

<#
    $path = 'OU=NL,DC=mds,DC=local'
    $path | Set-MDSLoginName
#>



