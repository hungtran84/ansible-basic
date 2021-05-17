# Download and install Vagrant and VirtualBox

- On Windows: manual (coming soon or...never come)

- On MacOS:

```bash
brew install vagrant
brew install virtualbox
```

Or ...Ansible :D (if you already have it)

```bash
ansible-playbook packages.yml
```

Note: if you don't have enough resource to spin up 4 VMs, change this line

```bash
Vagrant.configure("2") do |config|
    n=2
```

with n=1.

Run your vagrant to spin 2 x Ubuntu 18.04 (Bionic) boxes and 2 x CentOS 7 boxes (n=2).

```bash
vagrant up
Bringing machine 'ubuntu11' up with 'virtualbox' provider...
Bringing machine 'centos21' up with 'virtualbox' provider...
Bringing machine 'ubuntu12' up with 'virtualbox' provider...
Bringing machine 'centos22' up with 'virtualbox' provider...
```

Grab a beer and wait for the simple magic. It may fail if you forget to trust VirtualBox application from your MacOS.
