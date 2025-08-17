# CUR3direct
Ansible playbook to deploy reidirect servers

# Preamble

(See You Redirect)

## Reason

This provides a repeatable way to build the Podverse servers.
It also documents, what apps/configs are needed to run the servers.

This is only tested on Ubuntu 24.04; it will most likely not work on another distro

# Steps

## Patch server

ssh into server as root

```bash
apt update
apt upgrade -y
apt autoremove -y
apt autoclean -y
apt clean -y
snap refresh
reboot
```

## Ansible

### Setup Ansible on command ser (developer laptop)



#### pip install

In the podverse-ansible dir

```bash
python3 -m venv venv-ansible
source venv-ansible/bin/activate
python3 -m pip install --upgrade pip

python3 -m pip install ansible
python3 -m pip install ansible-lint
```

#### Activate venv

In the podverse-ansible dir

```bash
source venv-ansible/bin/activate
```

Then run ansible commands.

#### nix flake

```bash
nix develop
```

```bash
bash ./setup-ansible.sh
```

##### crypto

```bash
ansible-galaxy collection install community.crypto
```


#### Populate hosts

The file sets up the inventory of the various servers

Should look similar to the [example of hosts](example-hosts)

#### Ansible vault

##### Vault pasword file

Create strong password file at `~/.ansible/pv-vault-pass`


##### Create an encrypted vault file

```bash
EDITOR=vim ansible-vault create group_vars/all/vault.yml

```
Add Linode Secret

```bash
linode_api_key: your_actual_api_key_here

```

or 

Add Digital Ocean secret

```bash
digitalocean_api_key: your_actual_api_key_here

```

##### Edit vault

```bash
EDITOR=vim ansible-vault edit group_vars/all/vault.yml
py
```
#### Run playbook

```bash
ansible-playbook playbook-CUR3direct.yaml
```

### Notes

#### Let's encrypt

* Digital Oceaon https://certbot-dns-digitalocean.readthedocs.io/en/stable/
* Linode https://certbot-dns-linode.readthedocs.io/en/stable/