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
