# Hardened Nginx Docker Deployment using Puppet

This project sets up a secure, hardened Nginx web server inside a Docker container using Puppet.

What this does is that it
- Runs Nginx in a container with security best practices:
  - Read-only filesystem
  - All Linux capabilities dropped
  - Only specific writable paths (using tmpfs)
  - Runs as a non-root user (UID 101)
- Uses Puppet to automate the entire setup
- Uses Hiera to manage values like the exposed port

# How to run it

1. Make sure Docker and Puppet are installed on your machine.
2. Navigate to the project directory:
    cd ~/devops-project/puppet
3. Apply the Puppet manifest:
    sudo puppet apply manifests/nginx_hardened.pp --hiera_config=hiera/hiera.yaml
4. Check if Nginx is running:
    curl http://localhost:8080
5. You should see the default Nginx welcome page.

# Hardened Nginx Docker Deployment using Ansible
This section describes how the same hardened Nginx container is deployed using Ansible with Vault secret.

What it does is that it
1. Runs Nginx in a hardened Docker container,
      read-only file system
      cap-drop=ALL (drops all Linux capabilities)
      tmpfs mounts for required writable paths
      Runs as non-root user (UID 101)
2. Automates with Ansible
3. Secures port config using Ansible Vault

   # Steps to run it
   
1. Make sure Docker, Python 3, and Ansible are installed.
2. Navigate to the Ansible directory:
    cd ~/devops-project/ansible
3. Create a virtual environment and activate it:
    sudo apt install python3.12-venv -y
    python3 -m venv venv
    source venv/bin/activate
4. Install required packages:
    pip install docker
    ansible-galaxy collection install community.docker
5. Create the Ansible Vault file with the port value:
    ansible-vault create vault/vault.yml & add this line inside (nginx_port: 8081)
6. Run the playbook:
    ansible-playbook playbooks/nginx-hardened.yml --ask-vault-pass --ask-become-pass
7. Confirm if Nginx is running:
    curl http://localhost:8081
8. You should see the default Nginx welcome page.




# Hardened Nginx Docker Deployment using Terraform

This project sets up a secure, hardened Nginx web server inside a Docker container using Terraform.

What this does is that it
- Runs Nginx in a container with security best practices:
  - Read-only filesystem
  - All Linux capabilities dropped
  - Only specific writable paths (using tmpfs)
  - Runs as a non-root user (UID 101)
- Uses Terraform to automate the entire setup

# How to run it

1. Make sure Docker and Terraform are installed on your machine.
2. Navigate to the project directory:
    cd ~/devops-project/terraform/configs
3. Initialize Terraform:
    terraform init
4. Apply the Terraform configuration:
    terraform apply -auto-approve
5. Check if Nginx is running:
    curl http://localhost:8082
6. You should see the default Nginx welcome page.
