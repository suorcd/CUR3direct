#!/usr/bin/env bash

set -e

echo "Installing Ansible collections from requirements.yml..."
ansible-galaxy install -r requirements.yml
