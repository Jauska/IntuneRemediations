$regPath = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
$value = Test-Path $regPath
if($value){
        exit 0
 }
Else{
        exit 1
}