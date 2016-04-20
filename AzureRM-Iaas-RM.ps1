
# Stap 1: resourcegroup & locatie
$resourcegroup = 'datbedrijf-rds-iaas'
$location = 'West Europe'

New-AzureRmResourceGroup -Name $resourcegroup -Location $location

# Stap 2: Storage account
$storageAccountName = 'datbedrijfrdsstorage'
New-AzureRmStorageAccount -Name $storageAccountName -ResourceGroupName $resourcegroup -Type Standard_LRS $location

# Stap 3: Networking

$vnetName = 'datbedrijfrds-net'
$subnet = New-AzureRmVirtualNetworkSubnetConfig -Name serverSubnet -AddressPrefix 10.0.1.0/24
$vnet = New-AzureRmVirtualNetwork -name $vnetName -ResourceGroupName $resourcegroup -Location $location -AddressPrefix 10.0.0.0/16 -Subnet $subnet


$nicName = 'vm1-nic'
$pip = New-AzureRmPublicIpAddress -Name $nicName -ResourceGroupName $resourcegroup -Location $location -AllocationMethod Dynamic
$nic = New-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $resourcegroup -Location $location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id


# Stap 4: de VM
$vmName = 'RDS01'
$vm = New-AzureRmVMConfig -VMName $vmName -VMSize 'Basic_A1'

$cred = Get-Credential -Message 'Enter admin credentials' #rds-admin
$vm = Set-AzureRmVMOperatingSystem -VM $vm -Windows -ComputerName $vmName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate
$vm = Set-AzureRmVMSourceImage -VM $vm -PublisherName 'MicrosoftWindowsServer' -Offer 'WindowsServer' -Skus 'Windows-Server-Technical-Preview' -Version 'latest'

# Stap 5: Plaats de NIC
$vm=Add-AzureRmVMNetworkInterface -VM $vm -id $nic.Id


# Stap 6: Maak een VHD
$diskName = 'os-disk'
$storageAcc = Get-AzureRmStorageAccount -ResourceGroupName $resourcegroup -Name $storageAccountName
$osDiskUri = $storageAcc.PrimaryEndpoints.Blob.ToString() + 'vhds/' + $diskName + '.vhd'
$vm=Set-AzureRmVMOSDisk -VM $vm -Name $diskName -VhdUri $osDiskUri -CreateOption FromImage

# Stap 7: Maak de VM
New-AzureRMVM -ResourceGroupName $resourcegroup -Location $location -VM $vm

#Get-AzureRmVm -ResourceGroupName $resourcegroup -Name RDS01


# Stap 8: DSC

Publish-AzureRmVMDscConfiguration -ResourceGroupName $resourcegroup`
  -StorageAccountName $storageAccountName` 
  -ConfigurationPath .\Azure-IaaS-DSC.ps1 -Force


Set-AzureRmVMDscExtension -ResourceGroupName $resourcegroup`
   -VMName $vmname -ArchiveBlobName 'Azure-IaaS-DSC.ps1.zip'-ArchiveStorageAccountName $storageAccountName`
   -ConfigurationName 'WebServerConfig' -Version '2.15'
