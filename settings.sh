#!/usr/bin/env bash

__systemd_unig_src="./systemd/user"
__systemd_unit_dest="${HOME}/.local/share/systemd/user"
__systemd_unit_name="rclone-mount"
__systemd_unit_type="service"

__mount_target_root="${HOME}/rclone"
__rclone_config="${HOME}/.config/rclone/rclone.conf"
__regex="^\\[([^,]+)\\]$"
