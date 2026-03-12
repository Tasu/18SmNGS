#!/bin/bash
set -e

# Configure SSH user/password (can be overridden via env at runtime)
SSH_USER=${SSH_USER:-sshuser}
SSH_PASSWORD=${SSH_PASSWORD:-changeme}

# Ensure user exists and set password
if ! id -u "$SSH_USER" >/dev/null 2>&1; then
    useradd -m -s /bin/bash "$SSH_USER"
fi
echo "$SSH_USER:$SSH_PASSWORD" | chpasswd

# Make sure SSH allows password auth and disable root login for safety
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config || true
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config || true
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config || true

# Start sshd (keep as the foreground process so container stays alive).
mkdir -p /var/run/sshd
# We'll start jupyter in background below, then exec sshd in foreground
# so sshd becomes PID1 and the container keeps running.

# Start legacy Jupyter Notebook on port 8555, notebook dir /app/files, no token (dev only)
export JUPYTER_ALLOW_INSECURE_WRITES=1
# Start Jupyter Notebook on 127.0.0.1:8555 with base url /jupyter (dev only)
nohup pixi run jupyter-lab --no-browser --ip=0.0.0.0 --port=8555 --allow-root --ServerApp.root_dir=/app/files --ServerApp.token='' --ServerApp.password='' > /app/jupyter.log 2>&1 &

# Keep container alive by running sshd in foreground as PID1
# sshd is off in default
# exec /usr/sbin/sshd -D
