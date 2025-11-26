#!/usr/bin/env bash
# Installer for Netdata + vnStat (Debian/Ubuntu)
set -euo pipefail

if [[ "${EUID}" -ne 0 ]]; then
  echo "Please run this script as root." >&2
  exit 1
fi

echo "Updating repositories..."
apt update -y

echo "Installing Netdata + vnStat..."
apt install -y netdata vnstat

echo "Enabling services..."
systemctl enable --now netdata || true
systemctl enable --now vnstat || true

echo "Checking Netdata status:"
systemctl --no-pager --full status netdata || true

echo "Checking vnStat status:"
systemctl --no-pager --full status vnstat || true

echo "Netdata + vnStat installed successfully."
