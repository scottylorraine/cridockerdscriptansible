cp -r cri-dockerd /usr/local/bin/
chmod -R 0755 /usr/local/bin/cri-dockerd
chown -R root:root /usr/local/bin/cri-dockerd
cd /root/cri-dockerd/
install packaging/systemd/* /etc/systemd/system
sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service
systemctl daemon-reload
systemctl enable --now cri-docker.socket