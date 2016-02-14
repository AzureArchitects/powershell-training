$users = Import-Csv -Path C:\vagrant\export-jelle.csv -Delimiter ";"


foreach ($user  in $users){
    New-ADUser -Path 'OU=USA,DC=kontoso,DC=com' -Name $user.Name -StreetAddress $user.StreetAddress -Surname $user.SurName -Company $user.Company -Department $user.Department -City $user.City -State $user.State -PostalCode $user.PostalCode -HomePhone $user.HomePhone -MobilePhone $user.MobilePhone -EmailAddress $user.EmailAddress -HomePage $user.HomePage
}
