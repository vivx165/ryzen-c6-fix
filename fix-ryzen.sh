#!/bin/bash
CURRENT_USER=$USER

cd /home/$CURRENT_USER && git clone https://github.com/r4m0n/ZenStates-Linux

sudo bash -c "cat << EOF > /etc/systemd/system/disable-c6.service
[Unit]
Description=Disable Ryzen C6 State
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/usr/bin/python3 /home/$CURRENT_USER/ZenStates-Linux/zenstates.py --c6-disable
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF"

sudo systemctl daemon-reload
sudo systemctl enable --now disable-c6.service

echo "Done! Ryzen C6 state has been disabled successfully for user: $CURRENT_USER"
