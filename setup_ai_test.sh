#!/bin/bash

# This script installs Git and Ansible, clones the AI-Test repository,
# and then runs the 'setup_server_packages.yml' Ansible playbook on localhost.

# --- Function to check if a command exists ---
command_exists () {
  type "$1" &> /dev/null ;
}

echo "Starting setup script..."

# --- 1. Install Git and Ansible ---
echo "Checking and installing Git and Ansible..."

if command_exists apt-get; then
  # Ubuntu/Debian
  echo "Detected Ubuntu/Debian. Updating apt and installing packages..."
  sudo apt update -y
  sudo apt install -y git ansible
elif command_exists dnf; then
  # Fedora
  echo "Detected Fedora. Installing packages with dnf..."
  sudo dnf install -y git ansible
else
  echo "Unsupported operating system. Please install Git and Ansible manually."
  exit 1
fi

if [ $? -ne 0 ]; then
  echo "Error: Failed to install Git or Ansible. Exiting."
  exit 1
fi

echo "Git and Ansible installed successfully."

# --- 2. Clone the AI-Test repository ---
REPO_URL="https://github.com/afaranha/AI-Test.git"
REPO_DIR="AI-Test"

echo "Cloning the AI-Test repository..."

# Check if the directory already exists
if [ -d "$REPO_DIR" ]; then
  echo "Repository directory '$REPO_DIR' already exists. Skipping clone."
  cd "$REPO_DIR" || { echo "Error: Could not change directory to $REPO_DIR. Exiting."; exit 1; }
  # Pull latest changes if already cloned
  echo "Pulling latest changes from the repository..."
  git pull
else
  git clone "$REPO_URL"
  if [ $? -ne 0 ]; then
    echo "Error: Failed to clone repository. Exiting."
    exit 1
  fi
  cd "$REPO_DIR" || { echo "Error: Could not change directory to $REPO_DIR. Exiting."; exit 1; }
fi

echo "Successfully cloned/updated and entered the AI-Test repository."

# --- 3. Run the setup_server_packages.yml playbook on localhost ---
PLAYBOOK_NAME="setup_server_packages.yml"

echo "Running the Ansible playbook '$PLAYBOOK_NAME' on localhost..."

# --- Add local SSH key to authorized_keys for passwordless access (if needed) ---
echo "Setting up SSH key for localhost access..."
[ -f ~/.ssh/id_rsa.pub ] && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys || echo "Warning: ~/.ssh/id_rsa.pub not found, skipping key copy."
echo "SSH key setup complete."

# --- Run the setup_server_packages.yml playbook on localhost ---
ansible-playbook -i hosts.ini "$PLAYBOOK_NAME"

if [ $? -ne 0 ]; then
  echo "Error: Ansible playbook failed. Please check the output above for details."
  exit 1
fi

echo "Ansible playbook '$PLAYBOOK_NAME' completed successfully on localhost."
echo "Setup finished."
