# DevOps Automation Bash Scripts

This repository contains a collection of Bash scripts for automating various DevOps tasks, infrastructure setup, and system configurations.

## 📁 Repository Structure

### 🐳 Docker
Scripts for setting up and configuring Docker environments.
- `docker/admin_setup.sh`: Prerequisites installation and admin-level preparation for Rootless Docker. Requires `sudo`.
- `docker/user_setup.sh`: User-specific environment configuration and Rootless Docker initialization.

### 📊 Monitoring
Utilities for tracking system health and resource usage.
- `monitoring/disk_space_monitor.sh`: Checks disk usage against a threshold (default 80%) and reports status.
- `monitoring/system_monitor.sh`: Provides a quick snapshot of current CPU usage.

### 🖥️ System
General system administration and lab automation scripts.
- `system/vm_start.sh`: Automates the startup of multiple VMs on a remote Windows host using SSH and `vmrun`.

## 🚀 Getting Started

### Rootless Docker Setup

Rootless Docker allows running Docker containers as a non-root user, enhancing security by reducing the attack surface of the Docker daemon.

#### 1. Admin Preparation
Run this script as a user with `sudo` privileges. It installs necessary packages like `uidmap`, `dbus-user-session`, and `slirp4netns`, and enables user lingering.

```bash
sudo ./docker/admin_setup.sh
```

#### 2. User Initialization
Run this script as the non-root user who will be using Docker. It configures the `~.bashrc`, installs the rootless toolset, and starts the Docker daemon.

```bash
./docker/user_setup.sh
```

## 🛠️ Standards & Best Practices

- **Naming**: Scripts and directories follow `snake_case`.
- **Idempotency**: Scripts are designed to be safe to run multiple times.
- **Environment**: Primarily targeted at Debian/Ubuntu-based systems; some scripts (like `vm_start.sh`) have specific infrastructure dependencies.

---
*Maintained by the DevOps Team.*
