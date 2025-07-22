
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

# Install NVM (Node Version Manager)
echo "Task : Inatalling npm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Source NVM
source ~/.bashrc

# Install Node.js (version 18)

echo "Task : Inatalling npm"
nvm install 18
echo "Task : Inatalling npm complete"
echo "___________________________________________________________________________________________"

# Set Node.js 18 as Default
nvm use 18
nvm alias default 18

# Check Node and NPM version
node -v
npm -v

# Install Node-RED globally

echo "Task : Conf Node Start When Reboot"
sudo env "PATH=$PATH" npm install -g --unsafe-perm node-red

# Start Node-RED to verify installation
node-red &

# Setup Node-RED to run on reboot
echo "[Unit]
Description=Node-RED
Documentation=http://nodered.org
After=network.target

[Service]
# Set the environment variables for nvm
Environment=\"NVM_DIR=/home/admin/.nvm\"
Environment=\"PATH=\$PATH:/home/admin/.nvm/versions/node/v18.20.8/bin\"

# Run Node-RED using nvm's node
ExecStart=/bin/bash -c 'source /home/admin/.nvm/nvm.sh && /home/admin/.nvm/versions/node/v18.20.8/bin/node-red'
User=admin
Group=admin
WorkingDirectory=/home/admin
Restart=on-failure
Environment=\"NODE_OPTIONS=--max_old_space_size=1280\"

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/nodered.service > /dev/null


echo "Task : Conf Complete"
echo "_______________________________________________________________________________________________"
# Reload the systemd daemon to recognize the new service
#sudo systemctl daemon-reload

# Restart Node-RED service
#sudo systemctl restart nodered

# Check Node-RED service status
#sudo systemctl status nodered

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

# Reload the systemd daemon to recognize the new service
sudo systemctl daemon-reload

# Restart Node-RED service
sudo systemctl restart nodered

# Check Node-RED service status
sudo systemctl status nodered

echo "Installation complete! Node-RED and Tailscale should now be running."


