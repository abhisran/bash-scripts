#!/bin/bash

# Rootless Docker - Admin Preparation Script
# Run as sudo/root

set -e

echo "===== Installing Rootless Docker Prerequisites ====="

apt update

apt install -y \
    docker.io \
    uidmap \
    dbus-user-session \
    slirp4netns

echo ""

read -p "Enter username for rootless Docker setup: " USERNAME

echo ""
echo "===== Enabling linger for user: $USERNAME ====="

loginctl enable-linger "$USERNAME"

echo ""
echo "===== Admin setup completed successfully ====="

echo ""
echo "Ask the user '$USERNAME' to run the user setup script."
