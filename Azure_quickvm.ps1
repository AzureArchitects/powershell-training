# check the hotfix (should be installed already)
# get-Hotfix | ? { $_.HotfFixId -eq 'KB2883200'}

# Install package management here or you will not able to use Powershell-Get (this is already avalaible in Windows X or Server 2016). It is also on GitHub and part of WMF 5.0.
# But Exchange 2013 will not work with WMF 5.0 so check that out first.

# wget https://download.microsoft.com/download/4/1/A/41A369FA-AA36-4EE9-845B-20BCC1691FC5/PackageManagement_x64.msi

# Now you will be able to install the Azure module with

# Install-Module -Name Azure

# Here is how to install a VM

# Install-Module -Name Azure
# a699494373c04fc0bc8f2bb1389d6106__Windows-Server-2012-R2-20151022-en.us-127GB.vhd
# RoleSizelabel = Basic_A1 (1 cores, 1792 MB)

$subscription = 'Microsoft Partner Network'
$storageAccount = 'labintheboxstorage'
$location = 'West Europe'
$storageType = 'Standard_LRS'
$imagefamily = 'a699494373c04fc0bc8f2bb1389d6106__Windows-Server-2012-R2-20151022-en.us-127GB.vhd'
$vmname= 'lab02'
$instancesize = 'Basic_A1'
$admin = 'vagrant'
$password = 'Vagrant2015!'
$vnet = 'labintheboxVNET'
$subnet = 'apps'
$avset = 'labintheboxAVSet' #creates it on the fly
$servicename = 'labintheboxsvc001'

#Prepare
New-AzureStorageAccount -StorageAccountName $storageAccount -Location $location -Type $storageType
Set-AzureSubscription -SubscriptionName $subscription -CurrentStorageAccountName $storageAccount

new-AzureQuickVM -Windows -ServiceName $servicename -Name $vmname -Password $password -AdminUsername $admin -ImageName $imagefamily -Location $location -VNetName $vnet -SubnetNames 'apps' -InstanceSize $instancesize -AvailabilitySetName $avset
