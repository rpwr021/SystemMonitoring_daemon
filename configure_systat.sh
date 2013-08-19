#!/bin/bash

if [[ "$(id -u)" = "0"  ]]
then
	mkdir -p /tmp/lock/subsys/logs
	chmod -R 777 /tmp/lock/*
	cp -rf  ~/SysStat/ /opt/
	chmod -R 757  /opt/SysStat/
	cd /opt/SysStat/
	install -m 755  rsys_dmn -t /etc/init.d/ -v
	echo "SysStat daemon will Pick up configuration from /opt/SysStat/r_systat.config"
else
        echo "Usage: sudo ./configure_systat.sh";
		
fi
