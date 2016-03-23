Function Get-LotsOfUsefullInfo {

$hostname = hostname
for ($i=0;$i -lt 5; $i++) {  Add-Content .\dumpcomputers.txt $hostname }
$computers = Get-Content .\dumpcomputers.txt
$output = @();

foreach($entry in $computers) {
    
    $pspath = $PSVersionTable
    $psversion = @()
    foreach ($p in $pspath) {
        
        $psobject = [pscustomobject]@{
            PSVersie = $p.PSVersion
            WSMANVersie = $p.WSManStackVersion
        }
        
        $psversion += $psobject
        
    } 
   
    
	$info = Get-WmiObject -Class Win32_OperatingSystem -Computername $entry
	$bios = Get-WmiObject -Class Win32_Bios -Computername $entry
	   
       
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

    write-output $output 

}
