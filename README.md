# README #

This repository consists of an install and uninstall script, 
a systemd unit and a file containing common variables.

Just clone it and run `install.sh` AFTER configuring rclone.

Mount options and target directory can be customized in `settings.sh`.

The install script will:

* patch systemd unit
* install systemd unit
* create target directory
* parse rclone config
* create directory named after every rclone remote
* enable instances of the systemd unit for every remote
* start aforementioned instances
