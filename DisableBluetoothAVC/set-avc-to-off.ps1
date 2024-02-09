$regPath = "HKLM:\SYSTEM\ControlSet001\Control\Bluetooth\Audio\AVRCP\CT"
$regPathExists = Test-Path $regPath
$regkey = 'DisableAbsoluteVolume'

function regkeyiscorrect {
   return (((Get-ItemProperty -Path $regPath -Name $regkey).DisableAbsoluteVolume -eq 1))
}

If($regPathExists) {
    Remove-ItemProperty -Path $regPath -Name $regkey -ErrorAction SilentlyContinue
    New-ItemProperty -Path $regPath -Name $regkey -PropertyType "DWORD" -Value "1" -Force 
    if (regkeyiscorrect) {
        Return $true
    }
}elseif ($regPathExists -eq $false) {
    New-Item -Path $regPath -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path $regPath -Name $regkey -ErrorAction SilentlyContinue
    New-ItemProperty -Path $regPath  -Name $regkey -PropertyType "DWORD" -Value 1 
    if (regkeyiscorrect ) {
        Return $true
    }
}else {
    Return $false
}