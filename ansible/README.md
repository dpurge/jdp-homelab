# Homelab Ansible

Setup local WSL instance:

```sh
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible
ansible-playbook wsl-ubuntu.yml --ask-become-pass
```

Set up WinRM on the laptop:

```pwsh
# TODO
```

Run playbook against Windows on your laptop:

```sh
ansible-playbook --inventory inventory/homelab/hosts win-laptop.yml --extra-vars "host=laptop01 ansible_user=MyUser ansible_password=MyPass"
```

## Python setup

```sh
pyenv doctor
pyenv install -v 3.11.6
pyenv global 3.11.6
pyenv virtualenv 3.11.6 testproj
pyenv activate testproj
pyenv deactivate
```
