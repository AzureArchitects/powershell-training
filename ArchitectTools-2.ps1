function New-EicLoginInfo ()
{
    [CmdletBinding()]
      param(
        
        [string]$Firstname,
        [string]$Lastname
      
       )

       BEGIN{}
       PROCESS{
        
        $firstshort = $firstname.substring(0,3)
        $lastshort = $lastname.substring(0,3)
        $logon = $firstshort+$lastshort
        $new = $logon.tolower()
        $date = (Get-Date -format 'yyyyMMdd')

        Write-Output "$new en dienst op $date"


       
       }
       
       END{}
   
    
   
}

New-EicLoginInfo -Firstname 'Satya' -Lastname 'Nadella'
