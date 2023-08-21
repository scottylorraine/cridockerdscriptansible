                                             
#!/bin/bash

# Download and install Go 1.20.5
wget https://dl.google.com/go/go1.20.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.20.5.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bash_profile
source ~/.bash_profile

# Navigate to the cri-dockerd directory and build it
cd /root/cri-dockerd
mkdir -p bin
go build -o bin/cri-dockerd

# Install cri-dockerd
sudo mkdir -p /usr/local/bin
sudo install -o root -g root -m 0755 bin/cri-dockerd /usr/local/bin/cri-dockerd

# Copy systemd files and modify the cri-docker.service file
sudo cp -a packaging/systemd/* /etc/systemd/system
sudo sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service

# Reload systemd, enable and start the service and socket
sudo systemctl daemon-reload
sudo systemctl enable cri-docker.service
sudo systemctl enable --now cri-docker.socket
sudo systemctl start cri-docker.service 
sudo systemctl start --now cri-docker.socket
