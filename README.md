# App 1: Hardened Nginx Deployment

## Hardened Nginx Docker Deployment using Puppet

This project sets up a secure, hardened Nginx web server inside a Docker container using Puppet.

What this does is that it
- Runs Nginx in a container with security best practices:
  - Read-only filesystem
  - All Linux capabilities dropped
  - Only specific writable paths (using tmpfs)
  - Runs as a non-root user (UID 101)
- Uses Puppet to automate the entire setup
- Uses Hiera to manage values like the exposed port

### How to run it

1. Make sure Docker and Puppet are installed on your machine.
2. Navigate to the project directory:
    cd ~/devops-project/puppet
3. Apply the Puppet manifest:
    sudo puppet apply manifests/nginx_hardened.pp --hiera_config=hiera/hiera.yaml
4. Check if Nginx is running:
    curl http://localhost:8080
5. You should see the default Nginx welcome page.

## Hardened Nginx Docker Deployment using Ansible
This section describes how the same hardened Nginx container is deployed using Ansible with Vault secret.

What it does is that it
1. Runs Nginx in a hardened Docker container,
      read-only file system
      cap-drop=ALL (drops all Linux capabilities)
      tmpfs mounts for required writable paths
      Runs as non-root user (UID 101)
2. Automates with Ansible
3. Secures port config using Ansible Vault

   ### Steps to run it
   
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


## Hardened Nginx Docker Deployment using Terraform

This project sets up a secure, hardened Nginx web server inside a Docker container using Terraform.

What this does is that it
- Runs Nginx in a container with security best practices:
  - Read-only filesystem
  - All Linux capabilities dropped
  - Only specific writable paths (using tmpfs)
  - Runs as a non-root user (UID 101)
- Uses Terraform to automate the entire setup

### How to run it

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


# App 2: Hardened httpd (Apache) Deployment

## Hardened httpd Docker Deployment using Ansible
This sets up a secure, hardened Apache web server inside a Docker container using Ansible.

### What it does

Runs an Apache httpd container with:
    -Read-only filesystem
    -cap_drop=ALL
Automates deployment with Ansible

### How to run it

1. Make sure Docker, Python 3, and Ansible are installed.
2. Navigate to the Ansible directory
   cd /app2_httpd/ansible
3. Create and activate a virtual environment:
   python3 -m venv venv
   source venv/bin/activate
4. Install all the requirements:
     pip install docker
     ansible-galaxy collection install community.docker
5. Run the playbook
    ansible-playbook deploy_httpd.yml --ask-become-pass
6. Confirm httpd is running -
    curl http://localhost:8081
7. You should see the It works! page



## Hardened httpd Deployment with Terraform

This sets up a secure, hardened Apache web server inside a Docker container using Terraform.

### What it does:
- Pulls and runs the httpd:alpine image in a Docker container
- Enforces hardened settings:
    Read-only filesystem
    Dropped Linux capabilities (cap_drop=ALL)
    tmpfs mounts for writable paths
- Automates the deployment with Terraform

### How to run it:

1. Make sure Docker and Terraform are installed.
2. Navigate to the Terraform directory:
    cd ~/Dissertation/app2_httpd/terraform
3. Initialize Terraform:
    terraform init
4. Apply the configuration:
    terraform apply -auto-approve
5. Confirm httpd is running:
    curl http://localhost:8082
6. You should see the Apache It works! page.


## Hardened httpd Deployment with Puppet
This sets up a secure hardened Apache web server inside a Docker container using Puppet.

### What it does:
  -  It pulls and runs the httpd:alpine image in a Docker container
  -  Enforces hardened settings:
    - Read-only filesystem
    - Dropped Linux capabilities (cap_drop=ALL)
    - tmpfs mounts for required writable paths
  -  Automates the deployment with Puppet

### How to run it:

   1. Make sure Docker and Puppet are installed.
   2. Navigate to the Puppet directory:
cd ~/Dissertation/app2_httpd/puppet
   3. Apply the Puppet manifest:
sudo puppet apply manifests/deploy_httpd.pp
  4. Confirm httpd is running:
curl http://localhost:8083


# App 3: Hardened Alpine (with curl) Deployment

## Hardened Alpine + Curl Deployment with Terraform

This sets up a secure, hardened Alpine container with curl installed using Terraform.

### What it does:

    1. Pulls and runs the alpine Docker image
    2. Installs curl inside the container
    3. Enforces hardened settings:
        No privileged access
        IPC isolation
        Security options: no-new-privileges
    4. Automates the deployment with Terraform

### How to run it:

  1. Make sure Docker and Terraform are installed.
  2. Navigate to the Terraform directory:
      cd ~/Dissertation/app3_alpine/terraform
  3. Initialize Terraform:
      terraform init
  4. Apply the configuration:
      terraform apply -auto-approve
  5. Confirm the container is running:
      docker ps
  6. Test curl inside the container:
      docker exec -it alpine_tf curl https://example.com
  6. You should see the Apache It works! page.


## Hardened Alpine (with curl) Deployment using Ansible
This sets up a secure, hardened Alpine container inside Docker using Ansible.

### What it does:

    1. Pulls and runs alpine image
    2. Installs curl inside the container
    3. Enforces hardened settings:
       - No new privileges
       - IPC isolation
       - Non-privileged

### How to run it:

    1. Make sure Docker and Ansible are installed.
    2. Navigate to the Ansible directory:
        cd ~/Dissertation/app3_alpine/ansible
    3. Install requirements:
        ansible-galaxy collection install community.docker
    4. Run the playbook:
        ansible-playbook deploy_alpine.yml
    5. Confirm Alpine is running:
        docker ps
        docker exec -it alpine_ansible curl https://example.com
    6. You will see the Example Domain HTML.
