# README #

This repository consists of an install and uninstall script, a systemd unit and a file containing common variables.
Just clone it and run `install.sh` AFTER configuring rclone.

The install script will:
* patch the systemd unit based on the variable `__mount_target_root` in `settings.sh`
* install the systemd unit
* create directory specified in `__mount_target_root`
* parse the rclone config
* create a directory named after every rclone remote in `__mount_target_root`
* enable an instance of the systemd unit for every remote
* start the aforementioned instance
