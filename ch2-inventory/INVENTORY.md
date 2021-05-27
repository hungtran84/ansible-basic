# ansible inventory

## Static inventory

---

### 01. The static inventory with ip address only

- Quick look at the simples inventory

```ini
; IP Address only
192.168.100.11

192.168.100.12

192.168.100.21

192.168.100.22
```

- Verify inventory

```bash
ansible-inventory -i ch2-inventory/inventory/01-ipOnly.ini --graph
@all:
  |--@ungrouped:
  |  |--192.168.100.11
  |  |--192.168.100.12
  |  |--192.168.100.21
  |  |--192.168.100.22
```

---

### 02. Make the inventory more readable

- Inventory file with more frienly hostnames

```ini
ubuntu11 ansible_host=192.168.100.11

ubuntu12 ansible_host=192.168.100.12

centos21 ansible_host=192.168.100.21

centos22 ansible_host=192.168.100.22
```

- Look better now

```bash
ansible-inventory -i ch2-inventory/inventory/02-nonFQDN.ini --graph
@all:
  |--@ungrouped:
  |  |--centos21
  |  |--centos22
  |  |--ubuntu11
  |  |--ubuntu12
```

- Let run a simple ansible adhoc command

```bash
❯ ansible all -m ping -u ansible
ubuntu11 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
ubuntu12 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
centos21 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
centos22 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
```

---

### 03. Make the inventory more readable

- Create inventory with groups

```ini
fakehost.local

[ubuntu]
ubuntu11 ansible_host=192.168.100.11
ubuntu12 ansible_host=192.168.100.12

[centos]
centos21 ansible_host=192.168.100.21
centos22 ansible_host=192.168.100.22


[linux:children]
ubuntu
centos
```

- Run ansible adhoc command again a host group

```bash
ansible -i inventory/03-hostgroups-children.ini centos -m ping
centos21 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
centos22 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
```

---

### Exercise

- Create 3 previous inventories in YAML format. Refer to https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html

- Run ansible adhoc command to get the date/time of managed node

- Create PR to submit your work with following info:
    - Create your branch with the format: exercise-01-inventory-yml-{your name}
    - Create ch2-inventory/student<your_number> directory contains 3 files with the same name but YAML format
    - Commit and push to your remote branch
    - Submit your PR with command results in PR body

---

### Host Variables and Group Variables

- Using debug to find out the variable in Ansible inventory

```bash
ansible -i inventory/group_vars  all -m debug -a 'var=foo'
fakehost.local | SUCCESS => {
    "foo": "bar3"
}
centos21 | SUCCESS => {
    "foo": "bar1"
}
ubuntu12 | SUCCESS => {
    "foo": "bar2"
}
ubuntu11 | SUCCESS => {
    "foo": "bar"
}
centos22 | SUCCESS => {
    "foo": "bar1"
}
```
