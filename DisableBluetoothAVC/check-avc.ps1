$regPath = "HKLM:\SYSTEM\ControlSet001\Control\Bluetooth\Audio\AVRCP\CT"
$regPathExists = Test-Path $regPath
$regkey = 'DisableAbsoluteVolume'
$regkeyiscorrect = (((Get-ItemProperty -Path $regPath -Name $regkey -ErrorAction SilentlyContinue).DisableAbsoluteVolume -eq 1))
if($regPathExists){
        if ($regkeyiscorrect) {
                exit 0
        }
 }
Else{
        exit 1
}