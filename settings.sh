#!/usr/bin/env bash

__target_directory="${HOME}/rclone"
__rclone_options="--verbose --vfs-cache-mode writes"

# These variables should not be changed
__rclone_config="${HOME}/.config/rclone/rclone.conf"
__regex="^\\[([^,]+)\\]$"
__systemd_unit_name="rclone-mount"
__systemd_unit_type="service"
__systemd_unit_dest="${HOME}/.local/share/systemd/user"
