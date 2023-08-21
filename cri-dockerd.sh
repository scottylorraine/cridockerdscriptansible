                                             
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


