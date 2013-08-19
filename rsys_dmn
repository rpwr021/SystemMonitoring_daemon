#!/bin/sh
####
##service enabler for systat daemon 
##auth rpawar.021@gmail.com
####


. /etc/rc.d/init.d/functions

export lockfile=/tmp/lock/subsys/r_systat
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
                echo r_systat already running: $PID
		fi		
                exit 2; 
        else 
						/bin/touch "$lockfile"  "$STARTPIDFILE" > /dev/null 2>&1
						nohup /opt/SysStat/r_systat service  > /dev/null 2>&1 &
						PID=$!
						echo $"r_systat Started : PID is $PID" 
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
                echo $"Stopping r_systat  [OK]."
                killproc -p $STARTPIDFILE /opt/SysStat/r_systat
				/bin/rm "$lockfile"  "$STARTPIDFILE" > /dev/null 2>&1
				kill -9 `ps -ef  | grep -vE grep | grep rsys_dmn | cut -d " " -f2`      >/dev/null 2>&1
				kill -9 `ps -ef  | grep -vE grep | grep r_systat | cut -d " " -f2`      >/dev/null 2>&1
				kill -9 `ps -ef  | grep -vE grep | grep "sleep 1843" | cut -d " " -f2`  >/dev/null 2>&1
                echo "done!"
                rm -f $STARTPIDFILE
				
	fi			
	
	#killproc r_systat
	#kill `ps -ef | grep r_systat | grep -vE grep | cut -d " " -f2`
	
	
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
		echo $"r_systat is enabled. Running with PID `cat $STARTPIDFILE` "
		RETVAL=0
	else
		echo $"r_systat is not Running."
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
