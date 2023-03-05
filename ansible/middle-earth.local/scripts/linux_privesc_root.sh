#!/bin/bash

# Add GTFObins exploit
if ! grep -q tom /etc/sudoers; then
    echo 'tom     ALL=(ALL:ALL) NOPASSWD: /bin/systemctl' >> /etc/sudoers
fi
