#!/bin/bash -f


thost=$1
tuser=$2

	if [ -z "${thost}" ]
	then
		echo "\n Usage: $0 User hostName"
		
		exit 22
	fi

	if [ ! -f ${HOME}/.ssh/id_rsa.pub ]
	then
		echo "SSH not configured for user ${LOGNAME} - creating key..."
		ssh-keygen -trsa -N "" -f ~/.ssh/id_rsa
		STATUS=$?
		
		if [[ ${STATUS} -ne 0 ]]
		then
			echo "SSH configuration FAILED for ${LOGNAME}"
			exit ${STATUS}
		fi
		chmod 755 ${HOME}

	fi

	echo "SSH configured"
	scp ~/.ssh/id_rsa.pub ${tuser}@${thost}:id_rsa.pub.hotfix
	STATUS=$?

	if [[ ${STATUS} -ne 0 ]]
	then
		echo "scp of public key file to ${tuser}@${thost} FAILED!"
	exit ${STATUS}
	fi

	ssh ${tuser}@${thost} /bin/ksh <<ED
	if [ ! -d \${HOME}/.ssh ]
	then
		mkdir -p \${HOME}/.ssh	
	fi
	
	cat id_rsa.pub.hotfix >> \${HOME}/.ssh/authorized_keys
	chmod 600 \${HOME}/.ssh/authorized_keys
	chmod 755 \${HOME}
ED

STATUS=$?
	
 if [[ ${STATUS} -ne 0 ]]
 then
 	echo "Setting up passwordless SSH for  ${RUSER} FAILED!."
  	exit ${STATUS}
  fi
 
echo "Passwordless SSH set for  ${RUSER}."
	
