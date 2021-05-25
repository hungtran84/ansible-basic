$password = ConvertTo-SecureString -String "Hoanglinh90" -AsPlainText -Force
$user = Ansible
$op = Get-LocalUser | Where-Object {$_.Name -eq $user}
if (-not $op)
{
    New-LocalUser Ansible -Password $password -FullName "Ansible" -AccountNeverExpires -PasswordNeverExpires -UserMayNotChangePassword -Description "Ansible Account."| Out-Null
    Add-LocalGroupMember -Group "Administrators" -Member "Ansible"
}
else
{
    Write-Host "User exited"
}
