# Lab setup for windows managed node

## Build windows server using Vagrant
run your vagrant Windows2019
``` bash
vagrant up
Bringing machine 'win2019' up with 'virtualbox'
```

## Install and configure OpenSSH on windows node

Download the newest OpenSSH server from GitHub ( https://github.com/PowerShell/Win32-OpenSSH/releases )
In our case it is v8.1.0.0p1-Beta, 64-bit version.
Open the downloaded file and copy the "OpenSSH-Win64" folder to "C:\Program Files".

```powershell as administrator
setx PATH "$env:path;C:\Program Files\OpenSSH" -m
cd "C:\Program Files\OpenSSH"; .\install-sshd.ps1
Set-Service sshd -StartupType Automatic; Set-Service ssh-agent -StartupType Automatic; Start-Service sshd; Start-Service ssh-agent
```
- allow firewall
```powershell as administrator
New-NetFirewallRule -DisplayName "OpenSSH-Server-In-TCP" -Direction Inbound -LocalPort 22 -Protocol TCP -Action Allow
```

## Copy ssh public key from Ansible control host (ubuntu11) to windows13
SSH to VM
```create SSH-Keygen
ssh-keygen
## powershell module install Repair-AuthorizedKeyPermission
Install-Module -Force OpenSSHUtils -Scope AllUsers
```
```copy public key from ansible control host to windows server 2019 revise your located link on control host
scp /home/linhnh/.ssh/id_rsa.pub  Ansible@192.168.100.31:C:\Users\ansible\.ssh\authorized_keys
ssh --% Ansible@192.168.100.31 powershell -c $ConfirmPreference = 'None'; Repair-AuthorizedKeyPermission C:\Users\ansible\.ssh\authorized_keys

```
## Ssh from ubuntu11 to windows13 without password