# customize_airootfs.sh
# aoneill - 01/01/17

# Set bash to be the login shell
usermod -s /bin/bash root

# Copy over the database files
cp -r /root/dbs/* /var/lib/pacman/sync/
