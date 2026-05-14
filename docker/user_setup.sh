#!/bin/bash

# Rootless Docker - User Initialization Script
# Run as normal user (NO sudo)

set -e

echo "===== Configuring Environment Variables ====="

grep -q "DOCKER_HOST=unix:///run/user" ~/.bashrc || cat <<'EOF' >> ~/.bashrc

export XDG_RUNTIME_DIR=/run/user/$(id -u)
export DOCKER_HOST=unix:///run/user/$(id -u)/docker.sock

EOF

export XDG_RUNTIME_DIR=/run/user/$(id -u)
export DOCKER_HOST=unix:///run/user/$(id -u)/docker.sock

echo ""
echo "===== Installing Rootless Docker ====="

dockerd-rootless-setuptool.sh install

echo ""
echo "===== Starting Rootless Docker Daemon ====="

nohup dockerd-rootless.sh > ~/dockerd.log 2>&1 &

sleep 5

echo ""
echo "===== Verifying Docker ====="

docker info

echo ""
echo "===== Rootless Docker Setup Completed Successfully ====="

echo ""
echo "Useful Commands:"
echo "docker ps"
echo "docker images"
echo "docker run hello-world"

echo ""
echo "Docker daemon logs:"
echo "tail -f ~/dockerd.log"
