# ansible-basic

## GIT 101

- Create your own branch

```bash
git checkout -b hungts-exercise-01-inventory-yml
```

- Make your changes

- Commit your changes

```bash
git add README.md
git commit -m "Update README.md"
git push
```

- Create PR

##### Update Test By Huy #####
 [ansible@centos-01 ansible-basic]$ ansible all -i ch2-inventory/inventory/01-ipOnly.ini -m shell -a "date"
192.168.139.130 | CHANGED | rc=0 >>
Mon May 31 18:39:44 +07 2021
192.168.139.129 | CHANGED | rc=0 >>
Mon May 31 18:38:27 +07 2021
192.168.139.128 | CHANGED | rc=0 >>
Mon May 31 18:38:29 +07 2021

