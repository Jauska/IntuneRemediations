# Define variables
$ParentPath = $env:LOCALAPPDATA
$foldername = "testiappi"
$configfiletoedit = "settings_.dat"

# Construct the full search path
$FullSearchPath = Join-Path -Path $ParentPath -ChildPath $foldername

# Check if the path exists
if (-not (Test-Path -Path $FullSearchPath)) {
    exit 0
}

# Get the files to be edited
$FilesToBeEdited = Get-ChildItem -Path $FullSearchPath -Recurse -Filter $configfiletoedit

# Define the server addresses to check
$serverAddresses = @("ServerAddress=server1.jotain.com", "ServerAddress=server2.jotain.com", "ServerAddress=server3.jotain.com", "ServerAddress=server4.jotain.com")

# Loop through each file
ForEach ($FileToEdit in $FilesToBeEdited) {
    $FileContent = Get-Content -Path $FileToEdit.FullName

    # Check if the file content contains any of the server addresses
    foreach ($serverAddress in $serverAddresses) {
        if ($FileContent -contains $serverAddress) {
            exit 1
        }
    }

    # If none of the server addresses were found, exit with 0
    exit 0
}
