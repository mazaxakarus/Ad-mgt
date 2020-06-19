$servers = @(
"servername",
""
)
$Scripts = @()
foreach($FName in(Get-ChildItem -Path "c:\task\*.xml" ).Name){
  $Scripts += (get-content "c:\task\$FName" | out-string);
}

Invoke-Command -ComputerName $servers -ScriptBlock{
foreach($script in $using:Scripts){
  Register-ScheduledTask -Xml $script -TaskName "Weekly System Info Report" -user "domain\login" -Password "yourpassword" –Force
}
}

#
