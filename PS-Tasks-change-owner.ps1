$servers = @(
"servername"
)

$securedValue = Read-Host -AsSecureString                            #enter password
$bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securedValue)
$value = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)


Invoke-Command -ComputerName $servers -ScriptBlock{

$tasks = Get-ScheduledTask  -TaskPath "\" 
ForEach ($task in $tasks) {

   if (($task.Principal.userid -like "domain\oldusr") -or ($task.Principal.userid -like "oldusr" )) 
  {   
   $task.Principal.userid = "domain\new-usr"
  $task | set-scheduledtask -user "domain\new-usr" -Password $using:value
   }

}

 }
