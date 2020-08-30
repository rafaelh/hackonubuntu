import os

''' This file defines what the hackonubuntu script should do. '''

# TODO:
# amass
# sudo snap install john-the-ripper --devmode

# === Stuff to Remove ===

# These directories will be removed from your home directory
directories_to_remove = ['Documents', 'Music', 'Pictures', 'Public', 'Templates', 'Videos']

# These APT packages will be removed
packages_to_remove = []


# === Stuff to Add ===

# These kali packages will be installed
packages_to_install = ['most', 'ttf-mscorefonts-installer', 'pydf', 'htop', 'golang', 'exif', 'hexedit', 'jq', 'python3-pip', 
                       'python3-venv', 'python3-shodan', 'apt-transport-https', 'curl', 'filezilla', 'meld',
                       'net-tools', 'tmux']

# These python packages will be installed globally
pip_packages = ['pipenv', 'pylint']

# These go tools will be installed globally. You will need to have the following settings in your
# .bashrc already:
#
# export GOROOT=/usr/lib/go
# export GOPATH=$HOME/go
# export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
golang_modules_to_install = [
                            'github.com/OJ/gobuster',
                            'github.com/projectdiscovery/subfinder/cmd/subfinder',
                            'github.com/lc/gau',
                            'github.com/hakluke/hakrawler',
                            'github.com/hahwul/dalfox',
                            ]

# These git repositories will be synced to the 'external repo' directory
external_tools_directory = '/opt'
ext_repositories_to_sync = [
                            'https://github.com/danielmiessler/SecLists',
                            'https://github.com/swisskyrepo/PayloadsAllTheThings'
                            ]

# These git repositories will be synced to the 'personal repo' directory. I use my home directory.
personal_repo_directory = os.getenv("HOME")
personal_repositories_to_sync = [
                                'git@github.com:rafaelh/dotfiles',
                                'git@github.com:rafaelh/.private'
                                ]

# Next, take a look in the /scripts directory. Every script ending in .sh or .py will be run,
# provided it's # executable. For example, the current scripts install VS Code, Google Chrome and
# Typora. Any script that goes in this directory should be written so it can run multiple times
# without causing problems.
