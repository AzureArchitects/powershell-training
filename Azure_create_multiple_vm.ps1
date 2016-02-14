Set-AzureSubscription -SubscriptionName 'Free Trial' -CurrentStorageAccount 'icebabystorage01'

$pwd = 'admin2015!'
$user = 'demo01'


$ImageName = (Get-AzureVMImage |
                Where { $_.ImageFamily -eq 'Windows Server 2012 R2 Datacenter' } |
                sort PublishedDate -Descending | Select-Object -First 1).ImageName

for($i=1; $i -le 10 ; $i++) {
    
    $ip = $i + 10

    New-AzureVMConfig -Name "icecube0$i" -InstanceSize 'Small' -ImageName $ImageName |
    Add-AzureProvisioningConfig -Windows -AdminUsername $user -Password $pwd |
    Set-AzureSubnet -SubnetNames 'Subnet-1' |
    Set-AzureStaticVNetIP -IPAddress "10.10.1.$ip" |
    New-AzureVM -ServiceName 'icecloudservice'
    write-host "created box $i"
}
$
