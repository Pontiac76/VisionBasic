$path = 'G:\WinVice\GTK3VICE-3.7-win64\bin\'
$exe = 'x64sc.exe'
$vbConfig = 'vice_VB.ini'
$vb1Image = 'vb1.d64'
$parameters = "-config '$vbConfig' -autostart '$vb1Image' -9"
$vice = "$path\$exe"
if (!(Test-Path .\c1541.exe)) {Write-Error 'Error: c1541.exe is missing.';return}
Clear-Host
Write-Host 'Do you want to create a new blank file before executing the application?'
Write-Host '1) Create a new blank file'
Write-Host '2) Use an existing file'
Write-Host '3) Exit'
$choice = Read-Host 'Enter your selection (1, 2, or 3):'
if ($choice -eq '1') {
    $diskImage = Read-Host 'Enter the filename:'
    Invoke-Expression ".\c1541.exe -format project,01 d81 ${diskImage}.d81"
    $diskImage += '.d81'
} elseif ($choice -eq '2') {
    $files = Get-ChildItem -Filter '*.D81' | Sort-Object -Property Name -CaseSensitive:$false
    $i = 1
    Write-Host 'Select a file:'
    foreach ($file in $files) {Write-Host "$i) $file";$i++}
    $diskImage = Read-Host 'Enter the number of the file:'
    $diskImage = $files[$diskImage - 1]
} else {return}
$parameters += " $diskImage"
Write-Host "Invoking: $vice $parameters"
Invoke-Expression "$vice $parameters"
