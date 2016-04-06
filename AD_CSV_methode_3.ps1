$users = Import-Csv -Path .\export.csv -Delimiter ";"


foreach ($user  in $users){
    New-ADUser -Path 'OU=NL,DC=MDS,DC=local' -Name $user.Name -StreetAddress $user.StreetAddress -Surname $user.SurName -Company $user.Company -Department $user.Department -City $user.City -State $user.State -PostalCode $user.PostalCode -HomePhone $user.HomePhone -MobilePhone $user.MobilePhone -EmailAddress $user.EmailAddress -HomePage $user.HomePage
}
