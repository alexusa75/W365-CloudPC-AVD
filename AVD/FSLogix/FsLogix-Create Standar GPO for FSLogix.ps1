# Ensure the GroupPolicy module is available
Import-Module GroupPolicy

# Define parameters
$gpoName = "FsLogixTesting"
$gpoDescription = "GPO to configure profile settings"
$ouDN = "OU=Testing,DC=avd,DC=local" # Change to your target OU's distinguished name
$registryBasePath = "HKLM\SOFTWARE\FSLogix\Profiles"
$smblocation = "\\storage-account-name.file.core.windows.net\share-name"

# Define the registry values array with custom objects
$registryValues = @(
    [PSCustomObject]@{ValueName="Enabled"; DataType="DWORD"; Value=1; Description="REQUIRED"},
    [PSCustomObject]@{ValueName="DeleteLocalProfileWhenVHDShouldApply"; DataType="DWORD"; Value=1; Description="Recommended"},
    [PSCustomObject]@{ValueName="FlipFlopProfileDirectoryName"; DataType="DWORD"; Value=1; Description="Recommended"},
    [PSCustomObject]@{ValueName="LockedRetryCount"; DataType="DWORD"; Value=3; Description="Recommended"},
    [PSCustomObject]@{ValueName="LockedRetryInterval"; DataType="DWORD"; Value=15; Description="Recommended"},
    [PSCustomObject]@{ValueName="ProfileType"; DataType="DWORD"; Value=0; Description="Default"},
    [PSCustomObject]@{ValueName="ReAttachIntervalSeconds"; DataType="DWORD"; Value=15; Description="Recommended"},
    [PSCustomObject]@{ValueName="ReAttachRetryCount"; DataType="DWORD"; Value=3; Description="Recommended"},
    [PSCustomObject]@{ValueName="SizeInMBs"; DataType="DWORD"; Value=30000; Description="Default"},
    [PSCustomObject]@{ValueName="VHDLocations"; DataType="REG_SZ"; Value=$smblocation; Description="Example"},
    [PSCustomObject]@{ValueName="VolumeType"; DataType="REG_SZ"; Value="VHDX"; Description="Recommended"}
)


# Create a new GPO
$gpo = New-GPO -Name $gpoName -Comment $gpoDescription

# Link the GPO to the specified OU
New-GPLink -Name $gpoName -Target $ouDN

# Function to set registry values in the GPO
function Set-GpoRegistryValue {
    param (
        [string]$GpoName,
        [string]$KeyPath,
        [string]$ValueName,
        [string]$DataType,
        [Object]$Value,
        [string]$Description
    )
    If ($DataType -eq "REG_SZ") {
        $DataType = "String"
    }
    $gpo = Get-GPO -Name $GpoName
    Set-GPRegistryValue -Name $GpoName -Key $KeyPath -ValueName $ValueName -Type $DataType -Value $Value
    Write-Host "Set $ValueName ($Description) to $Value ($DataType)"
}


# Set the registry values from the array of custom objects
foreach ($regValue in $registryValues) {
    Set-GpoRegistryValue -GpoName $gpoName -KeyPath $registryBasePath -ValueName $regValue.ValueName -DataType $regValue.DataType -Value $regValue.Value -Description $regValue.Description
}

Write-Host "GPO '$gpoName' created and configured successfully."
