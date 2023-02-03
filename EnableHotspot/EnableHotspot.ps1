# Made by Apix | @Apix0n
# https://github.com/Apix0n/stuff
# EnableHotspot

# * Defines UWP classes
$connectionProfile = [Windows.Networking.Connectivity.NetworkInformation, Windows.Networking.Connectivity, ContentType = WindowsRuntime]::GetInternetConnectionProfile()
$tetheringManager = [Windows.Networking.NetworkOperators.NetworkOperatorTetheringManager, Windows.Networking.NetworkOperators, ContentType = WindowsRuntime]::CreateFromConnectionProfile($connectionProfile)

# * Starts the Mobile Hotspot
$tetheringManager.StartTetheringAsync() | Out-Null