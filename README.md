syscheck_daemon
===============

For Monitoring Multiple Linux servers (CPU , SWAP , MEM , No Processes) from a single machine , implemented as a daemon 


steps to configure (recommended to run these as sudo or root)


* Update User and hostnames (U can add multiple hosts && after installation configuration is picked up from under /opt/SysStat/r_systat.config)
	r_systat.config

* for same user and host/s run AddSSHEnv.sh
	to add remote ssh keys to configure all slaves for monitoring daemon , passwordless ssh 


* Now run .. lookout for errors 
	./configure_systat.sh

* finally run 
	  to launch daemon 
		sudo service rsys_dmn start	
	  to Stop 
		sudo service rsys_dmn stop

* Check logs in 
	/tmp/lock/subsys/logs/sysRun.log

* Also it generates mailer under,  mostly if there are no issues then it wont have any content , but u can use it to send mails   
	/tmp/info.html 


Also please go ahead if u have any improvements , let me know about em 
