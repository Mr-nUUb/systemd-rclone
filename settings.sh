#!/usr/bin/env bash

__target_directory="${HOME}/rclone"
__rclone_options="--verbose --vfs-cache-mode writes"

# These variables should not be changed
__rclone_config="${HOME}/.config/rclone/rclone.conf"
__regex="^\\[([^,]+)\\]$"
__systemd_unit_name="rclone-mount"
__systemd_unit_type="service"
# Which one is the better place?
# If we install to the first one and the user edits it, 
# it gets saved to the second one and our uninstall routine does not remove it...
__systemd_unit_dest="${HOME}/.local/share/systemd/user"
#__systemd_unit_dest="${HOME}/.config/systemd/user/"
