# Play around with ansible playbooks

## Simplest playbook of all time

- Create a simple playbook as below

```yaml
---
- name: The simplest playbook
  hosts: all
  gather_facts: no

  tasks:
    - name: Ping all hosts
      ping:
```

- Execute this playbook across nodes

```bash
ansible-playbook 01-ping.yaml
```

- Check the result

```bash
PLAY [The simplest playbook] **************************************************************************************************************

TASK [Ping all hosts] *********************************************************************************************************************
ok: [ubuntu12]
ok: [ubuntu11]
ok: [centos21]
ok: [centos22]

PLAY RECAP ********************************************************************************************************************************
centos21                   : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
centos22                   : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu11                   : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu12                   : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

- Task status
    - ok: The task ran successfully and no changes were made.
    - changed: The task ran successfully and a change was made.
    - failed: The task failed to run.
    - unreachable: The host was unreachable to run the task on.
    - skipped: This task was skipped.
    - ignored: This task was ignored (for example, in the case of ignore_errors).
    - rescued: This task was failed and rescue by rescue activities (likely the error handling)

## Ansible fact with `gather_fact`

- Create a simple playbook with `gather_fact` enabled

```yaml
---
- name: The simplest playbook
  hosts: all
  gather_facts: yes

  tasks:
    - name: Ping all hosts
      ping:
      when: ansible_os_family == 'Debian'
```

- Execute this playbook and check the managed node are skipped

```bash
ansible-playbook 02-gather-facts.yaml

PLAY [The simplest playbook] **************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************
ok: [centos22]
ok: [ubuntu11]
ok: [centos21]
ok: [ubuntu12]

TASK [Ping all hosts] *********************************************************************************************************************
skipping: [centos21]
skipping: [centos22]
ok: [ubuntu11]
ok: [ubuntu12]

PLAY RECAP ********************************************************************************************************************************
centos21                   : ok=1    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0   
centos22                   : ok=1    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0   
ubuntu11                   : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu12                   : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

## Extend your playbooks with `extra_vars` 

```yaml
---
- name: The demo playbook
  hosts: {{ myhosts }}
  gather_facts: yes

  tasks:
    - name: Get the current user
      shell: whoami
      register: myUser

    - name: Display the current user
      debug:
        msg: "The current user is {{ myUser.stdout }} "
```

- Pass the value to playbook variable

```bash
ansible-playbook 04-extra-vars.yaml -e "myhosts=centos"
```

## Loop and condition 

```yaml
---
- name: The demo playbook
  hosts: all
  gather_facts: yes
  become: yes # true = yes / false = no

  tasks:
    - name: create multiple directories
      file:
        path: "{{ item }}"
        state: directory
        owner: root
        group: root
        mode: 0775
      loop:
        - /tmp/a
        - /tmp/b
        - /tmp/c
      
      when: ansible_os_family == 'Debian'
```


