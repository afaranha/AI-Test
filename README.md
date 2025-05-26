# AI-Test Ansible Playbook

This repository contains an Ansible playbook designed to set up essential packages and configurations on new servers.

---

## Playbook: `setup_server_packages.yml`

### Purpose

The `setup_server_packages.yml` playbook automates the installation of fundamental tools and copies a custom tmux configuration file to the user's home directory.

### What it does:

-   **Installs Packages**: Ensures `tmux`, `vim`, and `git` are installed and up-to-date on the target servers.
-   **Configures Tmux**: Copies the `tmux.conf` file from this repository to `~/.tmux.conf` on the target servers, providing a consistent tmux environment.

### How to use it:

1.  **Clone the Repository**:
    ```bash
    git clone [https://github.com/afaranha/AI-Test.git](https://github.com/afaranha/AI-Test.git)
    cd AI-Test
    ```

2.  **Prepare your Inventory**:
    Ensure your Ansible inventory file (`hosts.ini` or another specified inventory) lists the servers where you want to run this playbook.

3.  **Run the Playbook**:
    Execute the playbook using the `ansible-playbook` command:
    ```bash
    ansible-playbook -i hosts.ini setup_server_packages.yml
    ```
    (Note: The `-i hosts.ini` part is only necessary if your inventory file is not in the default location or named differently.)

---

## Files in this Repository

-   `setup_server_packages.yml`: The main Ansible playbook.
-   `hosts.ini`: An example Ansible inventory file.
-   `tmux.conf`: The tmux configuration file to be copied.
-   `new_server_requirements.txt`: Additional server requirements.
-   `README.md`: This README file.

---

## Quick Setup with `setup_ai_test.sh`

For a quick setup on a fresh Linux server (Ubuntu/Debian or Fedora), you can use the `setup_ai_test.sh` script. This script will install Git and Ansible, clone this repository, and then run the `setup_server_packages.yml` playbook on your localhost.

**Step-by-step instructions:**

1.  **Download the script**:
    Use `curl` to download the `setup_ai_test.sh` script directly from the repository:
    ```bash
    curl -o setup_ai_test.sh [https://raw.githubusercontent.com/afaranha/AI-Test/main/setup_ai_test.sh](https://raw.githubusercontent.com/afaranha/AI-Test/main/setup_ai_test.sh)
    ```

2.  **Make the script executable**:
    Grant execute permissions to the downloaded script:
    ```bash
    chmod +x setup_ai_test.sh
    ```

3.  **Run the script**:
    Execute the script. This will perform the installation of Git and Ansible, clone the repository, and run the playbook:
    ```bash
    ./setup_ai_test.sh
    ```