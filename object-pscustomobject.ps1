

# Clear the content of the textfile (if it exists)
If (Test-Path .\dumpcomputers.txt) {
Clear-Content .\dumpcomputers.txt
}

# Populate the textfile 
$hostname = hostname
for ($i=0;$i -lt 5; $i++) {  Add-Content .\dumpcomputers.txt $hostname }
$computers = Get-Content .\dumpcomputers.txt

# Instantiate the array for the objects
$output = @();

# Loop through all $computers in $hostname file
foreach($entry in $computers) {
    

    # Let's create a complex object with an array as a property
    $psversions = $PSVersionTable
    $psversion = @()
    foreach ($p in $psversions) {
        
        $psobject = [pscustomobject]@{
            PSVersie = $p.PSVersion
            WSMANVersie = $p.WSManStackVersion
        }
        
        $psversion += $psobject
        
    } 
   
    
    # Collect other info
	$info = Get-WmiObject -Class Win32_OperatingSystem -Computername $entry
	$bios = Get-WmiObject -Class Win32_Bios -Computername $entry
	   
       
    # create the object for reporting
    $object = [pscustomobject]@{
                            fabrikant = $bios.manufacturer;
 			                serial = $info.serialnumber;
			                registratienaam = $info.registereduser;
			                datum = (Get-Date);
                            company = 'Contoso';
                            powershell = $psversion;
    
        }
	$output += $object
    }

$output | Export-Csv dump2.csv
