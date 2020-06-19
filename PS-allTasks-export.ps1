$servers = @(
"servername"
)

Invoke-Command -ComputerName $servers -ScriptBlock{
foreach($FName in(Get-ChildItem -Path "c:\task\*.xml" ).Name){
  Register-ScheduledTask -Xml (get-content "c:\task\$FName" | out-string) -TaskName "Weekly System Info Report" -user "domain\login" -Password "yurpassword" –Force
}
}

#
