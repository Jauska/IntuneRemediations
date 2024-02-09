$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\SystemGuard"
$value = Test-Path $regPath


if($value){
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\SystemGuard' -Name 'Enabled' -ErrorAction SilentlyContinue -Value 0
    $regkey = ((Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\SystemGuard' -Name 'Enabled' -ErrorAction SilentlyContinue).Enabled -eq 0)
    if ($regkey){
        exit 0
    }
}
Else {
    New-Item -Path $regPath -ErrorAction SilentlyContinue
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\SystemGuard' -Name 'Enabled' -ErrorAction SilentlyContinue -Value 0
    $regkey = ((Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\SystemGuard' -Name 'Enabled' -ErrorAction SilentlyContinue).Enabled -eq 0)
    if ($regkey){
        exit 0
    }else {
        exit 1
    }
}
