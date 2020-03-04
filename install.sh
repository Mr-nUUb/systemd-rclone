#!/usr/bin/env bash

source settings.sh

echo "This script will set up a directory structure"
echo "and systemd units based on your rclone config."
echo "Please run rclone first and set up your remotes."
read -p "Please press ENTER to continue or CTRL-C to cancel"

echo "Installing systemd unit..."
__systemd_unit_temp="/tmp/${__systemd_unit_name}@.${__systemd_unit_type}"
mkdir -p ${__systemd_unit_dest}
sed "s|\$__mount_target_root|${__mount_target_root}|g" \
    "${__systemd_unig_src}/${__systemd_unit_name}@.${__systemd_unit_type}" \
    > "${__systemd_unit_temp}"
cp -r "${__systemd_unit_temp}" ${__systemd_unit_dest}
rm -f ${__systemd_unit_temp}
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
