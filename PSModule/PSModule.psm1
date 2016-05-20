Set-StrictMode -Version Latest
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

#Internal Functions
Get-childitem "$here\functions" | Select -Expand FullName | Foreach {
   . $_
}


Export-ModuleMember -Function 'New-Welcome'
