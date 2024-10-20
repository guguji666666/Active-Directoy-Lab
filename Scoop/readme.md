# Use scoop to manage windows apps

## Powershell scripts used with scoop

### 1. List apps output from `scoope status`
```powershell
# Capture the output of `scoop status`
$scoopStatus = scoop status

# Initialize an empty array to store parsed objects
$parsedStatus = @()

# Parse each line of the output
foreach ($line in $scoopStatus) {
    # Use regex to extract the application name and status
    if ($line -match '^\s*(\S+)\s+(\S+)\s+(.*)$') {
        $appName = $matches[1]
        $currentVersion = $matches[2]
        $extraInfo = $matches[3]
        
        # Create a custom object for the parsed data
        $parsedStatus += [pscustomobject]@{
            AppName         = $appName
            CurrentVersion  = $currentVersion
            ExtraInfo       = $extraInfo
        }
    }
}

# Display the parsed output in a table format
$parsedStatus | Format-Table -AutoSize
```

![image](https://github.com/user-attachments/assets/272d50f9-29e3-4b98-b7d9-f99501468b8d)


### 2. Update apps listed in `scoope status`
```powershell
# Capture the output of `scoop status`
$scoopStatus = scoop status

# Initialize an empty array to store parsed objects
$parsedStatus = @()
$appList = @()

# Parse each line of the output
foreach ($line in $scoopStatus) {
    # Use regex to match and extract app data
    if ($line -match '@{Name=(.*?);.*Version=(.*?);.*Latest Version=(.*?);.*}') {
        $appName = $matches[1].Trim()
        $installedVersion = $matches[2].Trim()
        $latestVersion = $matches[3].Trim()
        
        # Create a custom object with the extracted data
        $app = [pscustomobject]@{
            AppName          = $appName
            InstalledVersion = $installedVersion
            LatestVersion    = $latestVersion
        }

        $parsedStatus += $app
        $appList += $appName
    }
}

# Display the parsed output in a table format
$parsedStatus | Format-Table -AutoSize

# Run `scoop update <appname>` for each detected application
foreach ($app in $appList) {
    Write-Host "Updating $app..."
    scoop update $app
}
```
![image](https://github.com/user-attachments/assets/562dc5a8-baac-43e3-ad6c-cf6c654edbe0)

