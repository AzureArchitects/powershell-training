$users = import-csv .\export.csv -Delimiter ';'

$pwd = convertto-securestring 'P@ssW0rD!' -asplaintext -force

$users | Select-Object *, 
@{name='samAccountName';expression={($_.first_name.Substring(0,3) + $_.last_name.Substring(0,3)).ToLower()}},
@{name='givenName';expression={$_.first_name}},
@{name='surname';expression={$_.last_name}},
@{name='name';expression={$_.first_name + ' ' + $_.last_name}},
@{name='displayName';expression={$_.first_name + ' ' + $_.last_name}},
@{name='Company';expression={$_.company_name}},
@{name='userPrincipalName';expression={($_.first_name.Substring(0,3) + $_.last_name.Substring(0,3)).ToLower() + '@mds.local'}},
@{name='Department';expression={$_.department_name}}, 
@{name='EmailAddress';expression={$_.email}} | New-ADUser -Enabled $true -AccountPassword $pwd -Path 'OU=NL,DC=MDS,DC=LOCAL'  

