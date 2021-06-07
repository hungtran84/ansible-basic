# Ansible vault

## Create a vault-encrypted file

```bash
ansible-vault create inventory/group_vars/all/vault
New Vault password: 
Confirm New Vault password:

---
vault_ansible_password: XXXXX
```

## Reference Vault Variables from Unencrypted Variables

```yaml
# group_vars/all/vars
ansible_user: ansible
ansible_password: "{{ vault_ansible_password }}"
```

## Verify the Password is Encrypted

```bash
ansible -m debug -a 'var=hostvars[inventory_hostname]' ubuntu11 --ask-vault-pass
Vault password:

............
ubuntu11 | SUCCESS => {
    "hostvars[inventory_hostname]": {
        "ansible_check_mode": false,
        "ansible_config_file": "/Users/hungts/ansible-basic/ch5-ansible-vault/ansible.cfg",
        "ansible_diff_mode": false,
        "ansible_facts": {},
        "ansible_forks": 5,
        "ansible_host": "192.168.100.11",
        "ansible_inventory_sources": [
            "/Users/hungts/ansible-basic/ch5-ansible-vault/inventory"
        ],
        "ansible_password": "XXXXXX",

```

