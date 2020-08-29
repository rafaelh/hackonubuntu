#!/usr/bin/env python3

import os
import apt
import subprocess
import sys
from updateactions import *
from config import (personal_repo_directory, external_tools_directory, directories_to_remove,
                    packages_to_install, packages_to_remove, pip_packages,
                    golang_modules_to_install, ext_repositories_to_sync,
                    personal_repositories_to_sync)

def main():
    # Get sudo privileges
    if elevate_privileges(): sys.exit(1)

    # Sync the script with Github version
    print_message("green", "Syncing 'update-kali' script")
    script_git_status = subprocess.Popen(["git", "-C", os.path.dirname(os.path.realpath(__file__)),
                                          "pull", "origin", "main"], stdout=subprocess.PIPE)
    script_git_status_output = script_git_status.communicate()[0]
    if "Already up to date" not in script_git_status_output.decode():
        print_message("red", "Script Updated. Please run the new version.\n")
        sys.exit(1)


    # Update and upgrade apt packages
    update_packages()

    # Install or remove specified apt packages
    print_message("green", "Checking installed packages")
    apt_cache = apt.Cache()
    for package in packages_to_install:
        install_package(package, apt_cache)
    for package in packages_to_remove:
        remove_package(package, apt_cache)

    # Install python modules
    installed_pip_packages = [r.decode().split('==')[0] for r in \
        subprocess.check_output([sys.executable, '-m', 'pip', 'freeze']).split()]
    pip_package_install(pip_packages, installed_pip_packages)

    # Take ownership of the external tools directory
    take_ownership(external_tools_directory)

    # Install golang tools
    for module in golang_modules_to_install:
        install_golang_module(module)

    # Create and remove specified directories
    print_message("green", "Checking directory structure")
    create_directory(personal_repo_directory)
    create_directory(external_tools_directory)
    for directory in directories_to_remove:
        remove_directory(directory)

    # Sync git repositories
    print_message("green", "Syncing git repositories")
    for repo in personal_repositories_to_sync:
        #sync_git_repo(repo.replace(".git", ""), personal_repo_directory)
        sync_git_repo(repo, personal_repo_directory)
    for repo in ext_repositories_to_sync:
        sync_git_repo(repo, external_tools_directory)

    # Run *.sh and *.py files in the /scripts directory
    print_message("green", "Checking for scripts to run")
    run_scripts()

    print("\nAll done. Go break stuff.\n")


if __name__ == '__main__':
    main()
