$IsInstalled = Get-Module -Name PSWindowsUpdate -ListAvailable
$Updates = $null
$exitcode = $null

function CheckUpdates {
    $Updates = Get-WindowsUpdate | Where-Object -Property Type -EQ -Value 1
    if ($Updates.Count -gt 0) {
        return 1
    }else {
        return 0
    }
    
}

if ($null -eq $IsInstalled) {
    Install-Module -Name PSWindowsUpdate -Repository PSGallery -AcceptLicense -Scope AllUsers -Force -Confirm:$false
    $exitcode = CheckUpdates
}elseif ($null -ne $IsInstalled) {
    Update-Module -Name PSWindowsUpdate -Scope AllUsers -Force -Repository PSGallery -Confirm:$false
    $exitcode = CheckUpdates
}

exit $exitcode