$servers = @(
"SERVERNAME"
)
Invoke-Command -ComputerName $servers -ScriptBlock{
$Threshold = -0
$exclude = "$($env:SystemDrive)\Users\Администратор"
$UserProfileFolders = Get-ChildItem "$($env:SystemDrive)\Users" | ? { $_.LastAccessTime -lt ((Get-Date).AddDays($Threshold)) } | Select Name,FullName,LastAccessTime
$WmiUserProfiles = Get-WmiObject Win32_UserProfile 
$WmiUserProfiles | % {if (($UserProfileFolders | Select -Expand FullName not ) -contains $_.LocalPath) {$_.Delete()}}  
Write-Host $servers 
}
