 Function New-ADUsers {
   
        [CmdletBinding() ]

        Param (
       
            [string] $Domain = ([adsi ]'').distinguishedName,
            [string] $DomainPath = "LDAP://$Domain ",
            [System.DirectoryServices.DirectoryEntry]$Root = [ADSI] "$DomainPath" ,
           
            [string] $NewOU,
            [string] $NewOUPath = "LDAP://OU=$NewOU ,$Domain" ,
            [System.DirectoryServices.DirectoryEntry]$Child = [ADSI] "$NewOUPath" ,
           
            [string] $ExistingOU,
            [string] $ExistingOUPath = "LDAP://$ExistingOU ,$Domain" ,

            [string] $ImportFile,

            [string] $Password

       
        )

        BEGIN{
           
            Write-Verbose 'This is an example of creating bulk users in AD with Powershell, using the ADSI method.'
       
        }
       
        PROCESS{

          
            if (! (Test-Path -Path $ImportFile )) {
                Write-Host " $ImportFile is not a valid file. Please check whether it exists and try again." -ForegroundColor Red
                Return
             }

            $users = Import-Csv $ImportFile -Delimiter ';'



             $filter = "(&(ObjectCategory=OrganizationalUnit)(ou=$newOU))"
             $result = ([adsisearcher ]"$filter "). FindAll()

             $count = $result. Count

             Write-Verbose "Search Result: $count"

                if($result.Count -eq 0) {

                        write-verbose 'OU does not exist. It will be created now.'
                        $OUResult = $Root. create('OrganizationalUnit', "OU=$newOU" )
                        $OUResult.SetInfo()
            
                    } else {
   
                        write-verbose 'OU exists. Users will be created in it.'
                }

                return
            Foreach ($user in $users) {

                if ($user.first_name. Length -ge 3) { $firstname_short = ($user.first_name).SubString(0 ,3) } else { $firstname_short = ($user.first_name).SubString(0 ,2)}
                if ($user.last_name. Length -ge 3) { $lastname_short = ($user.last_name).SubString(0 ,3) } else { $lastname_short = ($user.last_name).SubString(0 ,2)}
   
                $samAccountName = ($firstname_short + $lastname_short ).toLower()
                $displayName = $user. first_name + ' ' + $user. last_name

                $newUser = $Child. Create('User', "CN=$displayName" )
                $newUser.SetInfo()
               
                Write-Verbose "New user account created for $displayname. Now adding the password"

                $newUser.SAMAccountName = $samAccountName
                $newuSer.sn = $user.last_name
                $newUser.givenname = $user.first_name
                $newuser.displayName = $displayName
                $newuser.UserPrincipalName = $samAccountName + '@nocontoso.con'
                $newuser.description = 'User added by script at ' + ( Get-Date)
                $newuser.psBase.Invoke('setPassword' , $Password )
                $newuser.psBase.InvokeSet('Accountdisabled' , $false )

                $newUser.SetInfo()

                Write-Verbose "User is created with logon name $samAccountName"
            }
          }
       
        END{}

}


New-ADUsers -NewOU 'Sales' -ImportFile C:\Temp\export.csv -Password 'Winter2015!' -Verbose
