function New-EicLoginInfo ()
{
    [CmdletBinding()]
      param(
        
        [string]$Firstname,
        [string]$Lastname
      
       )

       BEGIN{}
       PROCESS {
        
        $firstshort = $firstname.substring(0,3)
        $lastshort = $lastname.substring(0,3)
        $logon = $firstshort+$lastshort
        $new = $logon.tolower()
        $date = (Get-Date -format 'yyyyMMdd')

        Write-Output "$new en dienst op $date"
         $properties = [ordered]@{'Logon'=$new;
         'Started'=$date}
                
                $obj = New-Object -TypeName PSObject -Property $properties
                Write-Output $obj
       
       }
       
       END{}
   
    
   
}

New-EicLoginInfo -Firstname 'Satya' -Lastname 'Nadella'
