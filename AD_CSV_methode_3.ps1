#rename the columns in this csv so that they match the proper AD attribute names

$users = Import-Csv -Path .\export.csv -Delimiter ";"


foreach ($user  in $users){
    New-ADUser -Path 'OU=NL,DC=MDS,DC=local' -Name $user.Name -StreetAddress $user.StreetAddress `
     -Surname $user.SurName -Company $user.Company -Department $user.Department ` 
     -City $user.City -State $user.State -PostalCode $user.PostalCode `
     -HomePhone $user.HomePhone -MobilePhone $user.MobilePhone -EmailAddress $user.EmailAddress `
     -HomePage $user.HomePage -accountPassword (ConvertTo-SecureString -AsPlainText "P@ssword2" -Force)
}
