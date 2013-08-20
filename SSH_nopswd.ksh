#!/bin/bash -f
#-----------------------------------------------
#
#NAME: SSH_nopswd.ksh
#auth rpawar.021@gmail.com
#PURPOSE: Add SSH public key to remote UNIX user account
#-----------------------------------------------

RUSER=$1
RHOST=$2

	if [ -z "${RHOST}" ]
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

	echo "SSH configured for ${LOGNAME} OK."

	echo "Processing ${RUSER}..."

	scp ~/.ssh/id_rsa.pub ${RUSER}@${RHOST}:id_rsa.pub.hotfix

	STATUS=$?

	if [[ ${STATUS} -ne 0 ]]
	then
		echo "scp of public key file to ${RUSER}@${RHOST} FAILED!"

		exit ${STATUS}
	fi

	ssh ${RUSER}@${RHOST} /bin/ksh <<EOT
		if [ ! -d \${HOME}/.ssh ]
		then
			#ssh-keygen -trsa -N \"\" -f ~/.ssh/id_rsa
			mkdir -p \${HOME}/.ssh	
		fi

		cat id_rsa.pub.hotfix >> \${HOME}/.ssh/authorized_keys
		chmod 600 \${HOME}/.ssh/authorized_keys
		chmod 755 \${HOME}
EOT

	STATUS=$?

	if [[ ${STATUS} -ne 0 ]]
	then
		echo "Adding SSH public key to user ${RUSER} FAILED!."
		exit ${STATUS}
	fi

	echo "Added SSH public key to user ${RUSER}."
#-------------------------------------------------------------------------
#	E	O	F
#-------------------------------------------------------------------------