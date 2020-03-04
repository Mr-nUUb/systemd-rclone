#!/usr/bin/env bash

__systemd_unig_src="./systemd/user"
__systemd_unit_dest=$HOME"/.local/share/systemd/user"
__systemd_unit_name="rclone-mount"
__systemd_unit_type="service"

__mount_target_root=$HOME"/OneDrive"
__rclone_config=$HOME"/.config/rclone/rclone.conf"
__regex="^\\[([^,]+)\\]$"

echo "This script will set up a directory structure"
echo "and systemd units based on your rclone config."
echo "Please run rclone first and set up your remotes."
read -p "Please press ENTER to continue or CTRL-C to cancel"

echo "Copying systemd unit..."
mkdir -p ${__systemd_unit_dest}
cp -r ${__systemd_unig_src} ${__systemd_unit_dest}
systemctl --user daemon-reload

mkdir -p ${__mount_target_root}
while read -r __line; do
    if [[ $__line =~ $__regex ]]; then
        echo "Processing remote \"${BASH_REMATCH[1]}\"..."
        __instance=$(systemd-escape "${BASH_REMATCH[1]}")
        __systemd_unit_full="${__systemd_unit_name}@${__instance}.${__systemd_unit_type}"

        echo "Creating mount point..."
        mkdir "${__mount_target_root}/${BASH_REMATCH[1]}"

        echo "Enabling and starting unit..."
        systemctl --user enable "${__systemd_unit_full}"
        systemctl --user start "${__systemd_unit_full}"
        
        echo
    fi
done < $__rclone_config
