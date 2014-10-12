#!/bin/sh
# backup/restore host ssh keys
# to be run during a DS workflow both, before and after the restoration

##Variables
STORAGEVOLUME="/Volumes/DSRuntime/ssh_storage"
RESTOREDVOLUME=$LAST_RESTORED_VOLUME
SYSTEMSERIAL=`system_profiler SPHardwareDataType | awk '/Serial Number/ { print $4; }'`
PATHTOFILE="${STORAGEVOLUME}/${SYSTEMSERIAL}.tar.gz"

#if the files are on the server, extract them to root
if [[ -f "${PATHTOFILE}" ]]; then
    tar xf ${PATHTOFILE} -C ${LAST_RESTORED_VOLUME}
#if the keys are not in the server but they are locally, backup them
elif [[ -f "/etc/ssh_host_rsa_key.pub" ]]; then
    tar czf ${PATHTOFILE} /etc/ssh_host_*key*
fi

exit 0
