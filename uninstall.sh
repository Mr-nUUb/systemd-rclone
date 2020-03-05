#!/usr/bin/env bash

source settings.sh

echo "This script will remove the directory structure"
echo "and systemd units based on your rclone config."
read -p "Please press ENTER to continue or CTRL-C to cancel"

while read -r __line; do
    if [[ $__line =~ $__regex ]]; then
        echo "Processing remote \"${BASH_REMATCH[1]}\"..."
        __instance=$(systemd-escape "${BASH_REMATCH[1]}")
        __systemd_unit_full="${__systemd_unit_name}@${__instance}.${__systemd_unit_type}"

        echo "Stopping and disabling systemd unit..."
        systemctl --user stop "${__systemd_unit_full}"
        systemctl --user disable "${__systemd_unit_full}"

        echo "Deleting mount point..."
        rmdir "${__target_directory}/${BASH_REMATCH[1]}"

        echo
    fi
done < $__rclone_config
rmdir ${__target_directory}

echo "Removing systemd unit..."
rm -f "${__systemd_unit_dest}/${__systemd_unit_name}@.${__systemd_unit_type}"
systemctl --user daemon-reload
