$source = New-xDscResourceProperty –Name Source -Type String -Attribute Key
$log = New-xDscResourceProperty –Name Log -Type String
$Ensure = New-xDscResourceProperty –Name Ensure -Type String -Attribute Write –ValidateSet “Present”, “Absent”


New-xDscResource –Name CheckEVLSource –Property $source, $Ensure,$log `
–Path 'C:\Program Files\WindowsPowerShell\Modules' –ModuleName CheckEVLSource

psedit "C:\Program Files\WindowsPowerShell\Modules\CheckEVLSource\DSCResources\CheckEVLSource\CheckEVLSource.psm1"

$source = "TEST"
[System.Diagnostics.EventLog]::SourceExists($source)
New-EventLog   -LogName Application -Source AGDSC
Remove-EventLog -source TEST -Verbose

configuration Test
{
    
    Import-DscResource -ModuleName CheckEVLSource

    node localhost
    {
        
        CheckEVLSource AGDSC
        {
           Ensure = "Present"
           Source = "AGDSC"
        }

    }
}
Test 
Start-DscConfiguration -ComputerName localhost -Path E:\Scripts\Test -Verbose
Test-DscConfiguration -ComputerName localhost -Path E:\Scripts\Test -Verbose
