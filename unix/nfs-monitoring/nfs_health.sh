#!/bin/bash
#Author: Daniel Schwartz 
#Date: 03.02.2015

#Defined Variable
logfile="/tmp/nfs_health.log"
mountpoint="/tmp/"
nfs_server="/tmp/"

#Check OS
OS=$(uname)

#Variable for Function
Linux_outlog=$(more /var/log/messages 2>&1 |grep "$nfs_server" | grep "not responding")
Solaris_outlog=$(more /var/adm/messages 2>&1| grep "$nfs_server" | grep "not responding")
Linux_out=$(stat "$mountpoint" 2>&1 | grep -i "stale")
Solaris_out=$(ls "$mountpoint" 2>&1 | grep -i "stale")


#Check if this script is already running
script_status=$(ps -ef | grep "nfs_health.sh" | grep -v grep | grep -v $$ | awk '{ print $2 }')
if  [ ! -z "$script_status" ]; then
kill -9 $script_status
fi

#Function
case $OS in
	Linux)	if [ "${Linux_out}" != "" ] || [ "${Linux_outlog}" != "" ]; then
		echo $(date) "NFS mount $mountpoint is stale or not responding" >> $logfile
		echo $(date) "*****STARTING RECOVERY ACTION*****" >> $logfile
		
		#Kill open file handles for that mountpoint
		file_handle=$(sudo /usr/sbin/lsof | egrep "$mountpoint" | awk '{print $2}' | sort -fu)
		for line in $file_handle
		do
			kill -9 $line
		done
		echo $(date) "All open file handles for "$mountpoint" has been killed" >> $logfile
		#Unmount 
		umount -f -l "$mountpoint"
		echo $(date) "$mountpoint has been unmounted" >> $logfile
		#Restart NFS and AUTOFS service
		/sbin/service nfs stop
		echo $(date) "NFS service stopped" >> $logfile
		/sbin/service autofs stop
		echo $(date) "Autofs service stopped" >> $logfile
		/sbin/service nfs start
		echo $(date) "NFS service started" >> $logfile
		/sbin/service autofs start
		echo $(date) "Autofs service started" >> $logfile
		echo $(date) "*****RECOVERY ACTION FINISHED*****" >> $logfile
	else
		echo $(date) "$mountpoint is fine" >> $logfile
	fi
;;
	SunOS)  if [ "${Solaris_out}" != "" ] || [ "${Solaris_outlog}" != "" ];then
		echo $(date) "NFS mount $mountpoint is stale or not responding" >> $logfile
		echo $(date) "*****STARTING RECOVERY ACTION*****" >> $logfile
		
		#Kill open file handles for that mountpoint
		file_handle=$(lsof | egrep "$mountpoint" | awk '{print $2}' | sort -fu)
                for line in $file_handle
                do
                        kill -9 $line
                done
		echo $(date) "All open file handles for "$mountpoint" has been killed" >> $logfile
		#Unmount
        	umount -f "$mountpoint"
		echo $(date) "$mountpoint has been unmounted" >> $logfile
		#Restart NFS and AUTOFS service
		svcadm disable /network/nfs/mapid
		svcadm disable /network/nfs/client
		svcadm disable /network/nfs/rquota
		echo $(date) "NFS services stopped" >> $logfile
		svcadm disable /system/filesystem/autofs
		echo $(date) "Autofs service stopped" >> $logfile
		svcadm enable /network/nfs/mapid
                svcadm enable /network/nfs/client
                svcadm enable /network/nfs/rquota
		echo $(date) "NFS services started" >> $logfile
		svcadm enable /system/filesystem/autofs
		echo $(date) "Autofs service started" >> $logfile
		echo $(date) "*****RECOVERY ACTION FINISHED*****" >> $logfile
	else
                echo $(date) "$mountpoint is fine" >> $logfile

	fi
;;
esac
