# Develop your own role

## Create new empty role

- Create a role called `apache2`

```bash
ansible-galaxy init apache2
- Role apache2 was created successfully
```

- Quick glance at newly created role

```bash
tree apache2
apache2
├── README.md
├── defaults
│   └── main.yml
├── files
├── handlers
│   └── main.yml
├── meta
│   └── main.yml
├── tasks
│   └── main.yml
├── templates
├── tests
│   ├── inventory
│   └── test.yml
└── vars
    └── main.yml
```

- Role metadata + README.md (sample)

```yaml
# meta/main.yml
galaxy_info:
  author: Hung Tran
  description: install and configure apache server on Linux
  company: Axon
  license: license (GPL-2.0-or-later, MIT, etc)
  min_ansible_version: "2.9"

  platforms:
  - name: EL
    versions:
    - "7"
  - name: Ubuntu
    versions:
    - "bionic"  

  galaxy_tags: []
dependencies: []
```

- 
