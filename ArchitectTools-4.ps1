 <#
  .Synopsis
    Creates a logon name 
   .Description
    Logon name
   .Example
    New-EicLoginInfo -Firstname 'Satya' -Lastname 'Nadella' -Verbose -LogErrors
   .Parameter Firstname
    Firstname
   .Inputs
    [string]
   .OutPuts
    [string]
   .Parameter Lastname
    Lastname
   .Inputs
    [string]
   .OutPuts
    [string]
   .Notes
    NAME:  EIC tools
    AUTHOR: EIC
    LASTEDIT: 11/9/2015
    KEYWORDS:
   .Link
 #Requires -Version 2.0
 #>



Function New-EicLoginInfo ()
{
    [CmdletBinding()]
      param(
        
        [parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [string]$Firstname,

        [parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [string]$Lastname,

        [string]$Errorlog = 'c:\temp\error.txt',

        [switch]$LogErrors
      
       )

       BEGIN{
       
       Write-Verbose "Errors are in $Errorlog"
       
       }
       PROCESS {
        
        Write-Verbose "We are generating the logon name for $firstname $lastname"
        
        
        try {
        $firstshort = $firstname.substring(0,3)
        $lastshort = $lastname.substring(0,3)
        $logon = $firstshort+$lastshort
        $new = $logon.tolower()
        $date = (Get-Date -format 'yyyyMMdd')
    
        } catch {

            if ($LogErrors) {
                  $ErrorMessage = $_.Exception.Message
                  $when = Get-Date
                  "$when -- Fouten gemaakt. Firstname = $Firstname Lastname = $Lastname. $ErrorMessage" | Out-File $Errorlog -Append

                  write-verbose "$when -- Fouten gemaakt. Firstname = $Firstname Lastname = $Lastname. $ErrorMessage"
                  Return
            }

        }

        
        
          Write-Verbose "$Firstname $Lastname is in dienst getreden op $date. Login name wordt $new."
          $properties = [ordered]@{'Logon'=$new;
            'Started'=$date}
                
                $obj = New-Object -TypeName PSObject -Property $properties
                Write-Output $obj
       
       }
       
       END{}
   
    
   
}

New-EicLoginInfo -Firstname 'Sat' -Lastname 'Nadella' -Verbose -LogErrors
