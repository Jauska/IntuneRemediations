$IsInstalled = Get-Module -Name PSWindowsUpdate -ListAvailable
function InstallUpdates {
    param (
        $InstallUpdate
    )
    if ($InstallUpdate.count -gt 0)  {
        Install-WindowsUpdate -Install -UpdateType Software -Confirm:$false
    } elseif ($InstallUpdate.count -eq 0) {
    Write-Output("No updates to install.")}
}

if ($null -eq $IsInstalled) {
    Install-Module -Name PSWindowsUpdate -Repository PSGallery -AcceptLicense -Scope AllUsers -Force -Confirm:$false
    $ToBeInstalled = Get-WindowsUpdate
    InstallUpdates -InstallUpdate $ToBeInstalled
}elseif ($null -ne $IsInstalled) {
    Update-Module -Name PSWindowsUpdate -Scope AllUsers -Force -Repository PSGallery -Confirm:$false
    $ToBeInstalled = Get-WindowsUpdate 
    InstallUpdates -InstallUpdate $ToBeInstalled
}
exit 0