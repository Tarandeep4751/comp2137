#!/bin/bash

# Function to check if a package is installed
is_package_installed() {
    dpkg -l "$1" &>/dev/null
}

# Function to display error messages
display_error() {
    echo "Error: $1"
    exit 1
}

# Function to update netplan configuration
update_netplan() {
        # Update netplan configuration

        sed -i 's/.*addresses:.*/      addresses: [192.168.16.21\/24]/' /etc/netplan/*.yaml
        sed -i 's/.*gateway4:.*/      gateway4: 192.168.16.1/' /etc/netplan/*.yaml
        sed -i 's/.*nameservers:.*/      nameservers: [192.168.16.1]/' /etc/netplan/*.yaml
        sed -i 's/.*search:.*/      search: [home.arpa, localdomain]/' /etc/netplan/*.yaml
        # Apply netplan changes
        netplan apply
    else
        echo "Netplan configuration is already up to date."
    fi
}
*# Update system and install required packages
display_message "Updating system and installing required packages..."
apt-get update || display_error "Failed to update the system."
apt-get install -y openssh-server apache2 squid ufw || display_error

# Function to configure and enable services
configure_services() {
    # Configure OpenSSH server
    sed -i 's/.*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
    systemctl restart ssh

    # Configure Apache2 server
      systemctl restart apache2

    # Configure Squid proxy
      systemctl restart squid

    # Configure UFW
    ufw allow 22
    ufw allow 80
    ufw allow 443
    ufw allow 3128
    ufw --force enable
}

# Function to create or update user accounts
create_users() {
    users=("dennis" "aubrey" "captain" "snibbles" "brownie" "scooter" "sandy" "perrier" "cindy" "tiger" "yoda")


echo "Creating user $user..."
            useradd -m -s /bin/bash "$user"
            # Add user to sudo group if it is dennis
            [ "$user" == "dennis" ] && usermod -aG sudo "$user"

        # Set up SSH keys for users
        user_home="/home/$user"
        mkdir -p "$user_home/.ssh"
        echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG4rT3vTt99Ox5kndS4HmgTrKBT8SKzhK4rhGkEVGlCI student@generic-vm" >> "$user_home/.ssh/authorized_keys"
        # Additional SSH key configurations can be added here
    done
}

echo "Script execution completed."


