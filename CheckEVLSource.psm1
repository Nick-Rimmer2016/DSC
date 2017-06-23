function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]$Source,

        [System.String]
        [Validateset("Absent","Present")]
        $Ensure="Present"
        
    )

    

    
    $returnValue = @{
    Source = $Source
    Ensure = $Ensure
    }

    $returnValue
    
}


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $Source,

        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure
    )

    New-EventLog -LogName Application -Source $source -Verbose 

}


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $Source,

        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure
    )

    $result = [System.Diagnostics.EventLog]::SourceExists($Source)

       
    $result
    
}


Export-ModuleMember -Function *-TargetResource

