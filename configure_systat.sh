#!/bin/bash

if [[ "$(id -u)" = "0"  ]]
then
	mkdir -p /tmp/lock/subsys/logs /opt/SysStat ~/SysStat/
	chmod -R 777 /tmp/lock/*
	
	for i in  nopswd_con.sh  configure_systat.sh  README.md  rsys_dmn  r_systat  r_systat.config 
	do
	cp -vf  $i ~/SysStat/
	done 
	
	cp -rf  ~/SysStat/ /opt/
	chmod -R 757  /opt/SysStat
	cd /opt/SysStat/
	install -m 755  rsys_dmn -t /etc/init.d/ -v
	echo "SysStat daemon will Pick up configuration from /opt/SysStat/r_systat.config"
else
        echo "Usage: sudo ./configure_systat.sh";
		
fi
