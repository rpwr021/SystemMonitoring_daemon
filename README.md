syscheck_daemon
===============

For Monitoring Multiple Linux servers (CPU , SWAP , MEM , No Processes) from a single machine , implemented as a daemon 


steps to configure 


*

* Update User and hostnames (U can add multiple hosts && after installation configuration is picked up from under /opt/SysStat/r_systat.config)
	r_systat.config
*finally run 
 	  sudo service rsys_dmn stop
* Check logs in 
	/tmp/lock/subsys/logs/sysRun.log
