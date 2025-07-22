
echo "_______________________________________________________________________________________________"
echo "__________________________________This script is made by Danial________________________________"
echo "_______________________________________________________________________________________________"
#!/bin/bash

# Update package lists
echo "Task : Updating the system"
sudo apt update
echo "Task : Updating Complete"
echo "______________________________________________________________________________________________"

# Install CURL and NANO
echo "Task : Installing Nano and Curl"
sudo apt install -y nano curl
echo "Task : Installing Nano and Curl Complete"
echo "_____________________________________________________________________________________________"


sudo apt update
sudo apt upgrade

# Install Tailscale
echo "Task : Inatalling Tailscale"
sudo mkdir -p /etc/apt/sources.list.d/
echo "deb [signed-by=/usr/share/keyrings/tailscale-archive-keyring.gpg] https://pkgs.tailscale.com/stable/ubuntu focal main" | sudo tee /etc/apt/sources.list.d/tailscale.list > /dev/null
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg > /dev/null

# Update package lists again
sudo apt update


# Install Tailscale
sudo apt install -y tailscale
echo "Task : Inatalling Tailscale complete"
echo "_______________________________________________________________________________________________"
# Enable and start Tailscale
sudo systemctl enable tailscaled --now
#sudo tailscale up


echo "Installation complete! Node-RED and Tailscale should now be running."
