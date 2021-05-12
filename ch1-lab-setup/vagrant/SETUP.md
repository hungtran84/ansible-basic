### Download and install Vagrant and VirtualBox
- On Windows: manual
- On MacOS:
```
brew install vagrant
brew install virtualbox
```
Or ...Ansible :D (if you already have it)
```
ansible-playbook packages.yml
```

Note: if you don't have enough resource to spin up 4 VMs, change this line
```
Vagrant.configure("2") do |config|
    n=2
```
with n=1.

Grab a beer and wait for the simple magic. It may fail if you forget to trust VirtualBox application from your MacOS.