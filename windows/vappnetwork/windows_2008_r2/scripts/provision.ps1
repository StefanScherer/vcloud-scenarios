$box = Get-ItemProperty -Path HKLM:SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName -Name "ComputerName"
$box = $box.ComputerName.ToString().ToLower()

Write-Host "This guest box is $box (registry ComputerName)"
Write-Host "This guest box is $env:COMPUTERNAME (env COMPUTERNAME)"

Write-Host "Provisioning done"
