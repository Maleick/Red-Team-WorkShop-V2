# Define the path to the current user's Downloads folder
$downloadsPath = "$env:USERPROFILE\Downloads"

# Create a hashtable to keep track of running processes
$runningProcesses = @{}

# Function to execute an executable file
function ExecuteFile($filePath) {
    try {
        # Check if the file is already running
        if (-not $runningProcesses.ContainsKey($filePath)) {
            $process = Start-Process -FilePath $filePath -PassThru -ErrorAction Stop
            $runningProcesses[$filePath] = $process
            Write-Host "Started $($process.ProcessName) from $filePath"
        }
        else {
            Write-Host "Already running"
        }
    }
    catch {
        Write-Host ""
    }
}

# Main loop
while ($true) {
    # Get all executable files in the Downloads folder
    $files = Get-ChildItem -Path $downloadsPath -Filter *.exe

    # Check each file
    foreach ($file in $files) {
        ExecuteFile $file.FullName
    }

    # Wait for 10 seconds before checking again
    Start-Sleep -Seconds 10
}
