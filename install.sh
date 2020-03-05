#!/usr/bin/env bash

source settings.sh

echo "This script will set up a directory structure"
echo "and systemd units based on your rclone config."
echo "Please run rclone first and set up your remotes."
read -p "Please press ENTER to continue or CTRL-C to cancel"
echo

echo "Installing systemd unit..."
__systemd_unig_src="./systemd/user"
__systemd_unit_temp="/tmp/${__systemd_unit_name}@.${__systemd_unit_type}"
sed "s|\$__target_directory|${__target_directory}|g; s|\$__rclone_options|${__rclone_options}|g" \
    "${__systemd_unig_src}/${__systemd_unit_name}@.${__systemd_unit_type}" \
    > "${__systemd_unit_temp}"
[[ -d ${__systemd_unit_dest} ]] || mkdir -p ${__systemd_unit_dest}
cp -r "${__systemd_unit_temp}" ${__systemd_unit_dest}
rm -f ${__systemd_unit_temp}
systemctl --user daemon-reload
echo

mkdir -p ${__target_directory}
while read -r __line; do
    if [[ $__line =~ $__regex ]]; then
        echo "Processing remote \"${BASH_REMATCH[1]}\"..."
        __instance=$(systemd-escape "${BASH_REMATCH[1]}")
        __systemd_unit_full="${__systemd_unit_name}@${__instance}.${__systemd_unit_type}"

        echo "Creating mount point..."
        mkdir "${__target_directory}/${BASH_REMATCH[1]}"

        echo "Enabling and starting unit..."
        systemctl --user enable "${__systemd_unit_full}"
        systemctl --user start "${__systemd_unit_full}"
        
        echo
    fi
done < $__rclone_config
