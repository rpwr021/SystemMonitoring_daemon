#!/bin/sh
####
##service enabler for systat daemon 
##auth rpawar@amdocs.com
####


. /etc/rc.d/init.d/functions

export lockfile=/tmp/lock/subsys/pil_systat
export STARTPIDFILE=/tmp/lock/subsys/logs/pidpil
export RETVAL=0
#export STIME=1800

initx() 
{

start() {
	
	if [ -f $STARTPIDFILE ] ; then
		if [ -z $PID ] ; then 
				RETVAL=1
                PID=`cat $STARTPIDFILE`
                echo pil_systat already running: $PID
		fi		
                exit 2; 
        else 
						/bin/touch "$lockfile"  "$STARTPIDFILE" > /dev/null 2>&1
						nohup /pil_user2/pil/users/piltools/SysStat/pil_systat service  > /dev/null 2>&1 &
						PID=$!
						echo $"pil_systat Started : PID is $PID" 
						RETVAL=$?
						echo $PID > $STARTPIDFILE
						[ $RETVAL -eq 0 ] && touch ${lockfile} && success || failure
						echo
						echo $PID > ${STARTPIDFILE}
                return $RETVAL
        fi
		
	
}

stopx() {
	
	
	if [[ -s $STARTPIDFILE ]] ; then
                echo $"Stopping pil_systat  [OK]."
                killproc -p $STARTPIDFILE /pil_user2/pil/users/piltools/SysStat/pil_systat
				/bin/rm "$lockfile"  "$STARTPIDFILE" > /dev/null 2>&1
				kill -9 `ps -ef  | grep -vE grep | grep pilsys_dmn | cut -d " " -f2`      >/dev/null 2>&1
				kill -9 `ps -ef  | grep -vE grep | grep pil_systat | cut -d " " -f2`      >/dev/null 2>&1
				kill -9 `ps -ef  | grep -vE grep | grep "sleep 1843" | cut -d " " -f2`  >/dev/null 2>&1
                echo "done!"
                rm -f $STARTPIDFILE
				
	fi			
	
	#killproc pil_systat
	#kill `ps -ef | grep pil_systat | grep -vE grep | cut -d " " -f2`
	
	
}

restart() {
	stopx
	start
}


case "$1" in
  start)
	start
	;;
  stop) 
	stopx
	;;
  restart)
	restart
        ;;
  status)
	if [ -f $lockfile ]; then
		echo $"pil_systat is enabled. Running with PID `cat $STARTPIDFILE` "
		RETVAL=0
	else
		echo $"PIL_systat is not Running."
		RETVAL=3
	fi
	;;
  *)
	echo $"Usage: $0 {start|stop|status|restart}"
	exit 1
esac


exit $RETVAL

}


initx $1