$box = Get-ItemProperty -Path HKLM:SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName -Name "ComputerName"
$box = $box.ComputerName.ToString().ToLower()

Write-Host "This guest box is $box (registry ComputerName)"
Write-Host "This guest box is $env:COMPUTERNAME (env COMPUTERNAME)"

Write-Host "Adding second disk D"

$addDriveD = @'
select disk 1
attributes disk clear readonly
online disk
create partition primary
format quick
assign letter D
'@

$addDriveD | Out-File $env:TEMP\addDriveD.txt -Encoding ascii
& diskpart /s $env:TEMP\addDriveD.txt

Write-Host "Provisioning done"
