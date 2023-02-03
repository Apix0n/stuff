# Made by Apix | @Apix0n
# https://github.com/Apix0n/stuff
# EnableHotspot

# * Defines UWP classes and needed variables
$connectionProfile = [Windows.Networking.Connectivity.NetworkInformation,Windows.Networking.Connectivity,ContentType=WindowsRuntime]::GetInternetConnectionProfile()
$tetheringManager = [Windows.Networking.NetworkOperators.NetworkOperatorTetheringManager,Windows.Networking.NetworkOperators,ContentType=WindowsRuntime]::CreateFromConnectionProfile($connectionProfile)
$ApixStartup = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
$ApixTable = @($tetheringManager.GetCurrentAccessPointConfiguration())

# * Gets the SSID, removes all the blank lines
Format-Table SSID -InputObject $ApixTable -HideTableHeaders > "ssidtmp.txt"
$ApixSSID = @(Get-Content ssidtmp.txt | Where-Object { $_ -ne "" } )
Remove-Item ".\ssidtmp.txt"

# * Gets the Passphrase, removes all the blank lines and the spaces before and after
Format-Table Passphrase -InputObject $ApixTable -HideTableHeaders > "passphrasetmp.txt"
$ApixPassphraseWl = @(Get-Content passphrasetmp.txt | Where-Object { $_ -ne "" } )
$ApixPassphrase = @($ApixPassphraseWl.trim()) 
Remove-Item ".\passphrasetmp.txt"

# * Creates a QR Code and opens it
$ApixQRData = "WIFI:S:$ApixSSID;T:WPA;P:$ApixPassphrase;;"
Invoke-WebRequest "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=$ApixQRData" -OutFile "QR-$ApixSSID.png"
Invoke-Item ".\QR-$ApixSSID.png"

# * Writes the SSID and the Passphrase of the Mobile Hotspot
Write-Output "SSID: $ApixSSID`nPassphrase: $ApixPassphrase" > "SSIDnPassphrase-$ApixSSID.txt"

# * Downloads the EnableHotspot.bat, puts it in the Startup folder and runs it
Invoke-WebRequest "https://raw.githubusercontent.com/Apix0n/stuff/main/EnableHotspot/EnableHotspot.bat" -OutFile "$ApixStartup\Hotspot.bat"
Invoke-Item "$ApixStartup\Hotspot.bat"

# * Disables the "Energy Saving" feature
    # ToFix: Automatic solution (does not work on 22621)
#// $tetheringManager.DisableNoConnectionsTimeout()
# https://learn.microsoft.com/en-us/uwp/api/windows.networking.networkoperators.networkoperatortetheringmanager.disablenoconnectionstimeout
    # TempSolution: Opens the Settings and the user disables it manually
Start-Process "ms-settings:network-mobilehotspot"