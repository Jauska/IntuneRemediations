$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\SystemGuard"
$value = Test-Path $regPath
$regkey = ((Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\SystemGuard' -Name 'Enabled' -ErrorAction SilentlyContinue).Enabled -eq 0)
if($value){
        if ($regkey) {
                exit 0
        }
 }else{
        exit 1
}