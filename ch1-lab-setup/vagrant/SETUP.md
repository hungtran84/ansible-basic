# Lab setup

## Download and install Vagrant and VirtualBox

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

## Spin up Linux boxes

Run your vagrant to spin 2 x Ubuntu 18.04 (Bionic) boxes and 2 x CentOS 7 boxes (n=2).

```bash
vagrant up
Bringing machine 'ubuntu11' up with 'virtualbox' provider...
Bringing machine 'centos21' up with 'virtualbox' provider...
Bringing machine 'ubuntu12' up with 'virtualbox' provider...
Bringing machine 'centos22' up with 'virtualbox' provider...
```

Grab a beer and wait for the simple magic. It may fail if you forget to trust VirtualBox application from your MacOS.

## Setup Ansible service account (all nodes)

### Create Ansible user

- Check VM status

```bash
vagrant status
Current machine states:

ubuntu11                  running (virtualbox)
centos21                  running (virtualbox)
ubuntu12                  running (virtualbox)
centos22                  running (virtualbox)
```

- Ssh to any Linux box with vagrant

```bash
vagrant ssh ubuntu11
Welcome to Ubuntu 18.04.5 LTS (GNU/Linux 4.15.0-143-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Mon May 17 09:35:15 UTC 2021

  System load:  0.03              Processes:             117
  Usage of /:   2.7% of 38.71GB   Users logged in:       0
  Memory usage: 1%                IP address for enp0s3: 10.0.2.15
  Swap usage:   0%                IP address for enp0s8: 192.168.100.11



New release '20.04.2 LTS' available.
Run 'do-release-upgrade' to upgrade to it.

vagrant@ubuntu-bionic:~$
```

- Create user for ansible (DO NOT USER ROOT ACCOUNT)

```bash
sudo useradd -m -s /bin/bash ansible
sudo passwd ansible
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully
```

- Grant root priviledge to ansible user

```bash
sudo bash -c 'echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible'
```

- Enable Password Authentication if it has been disabled

```bash
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd.service
```

### Configure Ansible control node (ubuntu11)

- Generate an ssh key

```bash
su - ansible
ssh-keygen
```

- Copy ssh public key to the managed nodes

```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub ansible@192.168.100.21
```

- You should be able to ssh to another Linux box without password

```bash
ssh ansible@192.168.100.21 date
Mon May 17 10:41:58 UTC 2021
```

Let do some Ansible works.
