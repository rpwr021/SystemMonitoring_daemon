syscheck_daemon
===============

For Monitoring Multiple Linux servers (CPU , SWAP , MEM , No Processes) from a single machine , implemented as a daemon 


steps to configure (recommended to run these as sudo or root)


* Update User and hostnames (U can add multiple hosts && after installation configuration is picked up from under /opt/SysStat/r_systat.config)
	r_systat.config

* for same user and host/s run AddSSHEnv.sh
	to add remote ssh keys to configure all slaves for monitoring daemon , passwordless ssh 

*finally run 
	  to launch daemon 
		sudo service rsys_dmn start	
	  to Stop 
		sudo service rsys_dmn stop

* Check logs in 
	/tmp/lock/subsys/logs/sysRun.log


