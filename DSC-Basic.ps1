configuration SFTP_Servers

{
    
    param (
            [Parameter(Mandatory=$true)]
            [ValidateNotNullOrEmpty()]
            [String[]]$ComputerName
          )
   
    Import-DscResource -ModuleName xPSDesiredStateConfiguration -ModuleVersion 6.4.0.0
    Import-DscResource -ModuleName cNtfsAccessControl 
    Import-LocalizedData -BaseDirectory .\ -FileName sftp-config.psd1 -BindingVariable Data
    
    node $computername   

    {
        File DSCResourceFolder
        {
            Ensure = "Present"
            SourcePath = "\\dc1\dscresource"
            DestinationPath = "C:\Program Files\WindowsPowerShell\Modules"
            Recurse = $true
            Type = "Directory"
        }

        File BinFilePresent
        {
            Ensure = "Present"
            SourcePath = "\\dc1\dscresource\test.bin"
            DestinationPath = $data.bin
            Type = "File"
            DependsOn = '[File]CreateFileStructure' 
        }
                       
        File CreateFileStructure
        {
            Ensure          = "Present"
            DestinationPath = $data.FolderStructure
            Type            = "Directory"
            
            
        } 

        cNtfsPermissionEntry PermissionSet1
        {
        Ensure = 'Present'
        Path = "C:\home\test"
        Principal = $data.Username
        AccessControlInformation = @(
            cNtfsAccessControlInformation
            {
                AccessControlType = 'Allow'
                FileSystemRights = 'ReadAndExecute'
                Inheritance = 'ThisFolderSubfoldersAndFiles'
                NoPropagateInherit = $false
            }
        )
        DependsOn = '[File]CreateFileStructure','[File]DSCResourceFolder' 
         
        }
}
}

SFTP_Servers -OutputPath C:\Scripts\DSC -computername APP1,APP2

Start-DscConfiguration  -Wait -Path C:\Scripts\DSC -Verbose -Force
Test-DscConfiguration -ComputerName APP1 -Verbose -Detailed
Test-DscConfiguration -ComputerName APP2 -Verbose -Detailed

#New-SmbShare -Name "DSCResource" -Path "C:\Resources" -ReadAccess "psdevops\APP1$","psdevops\domain admins"
