$hostname = hostname
for ($i=0;$i -lt 5; $i++) {  Add-Content .\computers.txt $hostname }
$computers = Get-Content .\computers.txt
$output = @();

foreach($entry in $computers) {
	$info = Get-WmiObject -Class Win32_OperatingSystem -Computername $entry
	$bios = Get-WmiObject -Class Win32_Bios -Computername $entry
	$environment = [System.Environment]::GetEnvironmentVariables();
    
       
    $object = New-Object -TypeName psobject -Property @{
                            fabrikant = $bios.manufacturer;
 			                serial = $info.serialnumber;
			                registratienaam = $info.registereduser;
			                datum = (Get-Date);
                            company = 'Contoso';
                            pad = $environment.Item("Path");
    
        }
	$output += $object
}

$output | Export-Csv inventory2.csv -NoTypeInformation

