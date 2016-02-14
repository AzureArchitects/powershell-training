$users = import-csv .\export.csv -Delimiter ';'

$pwd = convertto-securestring 'P@ssW0rD!' -asplaintext -force

$users | foreach-object {

    $sam = $_.first_name.Substring(0,3) + $_.last_name.Substring(0,3)
    $thename = $_.first_name + ' ' + $_.last_name

    New-Aduser -Name $thename -SamAccountName $sam `
     -AccountPassword $pwd -Enabled $true -GivenName $_.first_name -Path 'OU=USA,DC=kontoso,DC=com' 


}
