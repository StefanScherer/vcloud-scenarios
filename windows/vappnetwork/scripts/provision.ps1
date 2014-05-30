$box = Get-ItemProperty -Path HKLM:SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName -Name "ComputerName"
$box = $box.ComputerName.ToString().ToLower()

Write-Host "This guest box is $box (registry ComputerName)"
Write-Host "This guest box is $env:COMPUTERNAME (env COMPUTERNAME)"


Write-Host "Enable Remote Desktop"
# from http://networkerslog.blogspot.de/2013/09/how-to-enable-remote-desktop-remotely.html
#
# 1) Enable Remote Desktop
set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0

# 2) Allow incoming RDP on firewall
# Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
& netsh advfirewall firewall set rule group="Remote Desktop" new enable=yes

# 3) Enable (less) secure RDP authentication to make it work from Linux host with rdesktop
set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 0

Write-Host "Provisioning done"
