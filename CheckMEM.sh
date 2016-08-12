#!/bin/bash

#Volition21 12/08/2016

free=`free -mt | grep Mem | awk '{print $4}'`
hostname=`hostname -f`
memthreshold='75' #In megabytes.
email='tech@lists.cassa.org.au'


if [ $free -lt $memthreshold ]; then
	echo > /tmp/processes.txt
	echo 'Warning, free physical memory on '$hostname' is '$free'mb' >> /tmp/processes.txt
	echo >> /tmp/processes.txt
        ps -eo %mem,pid,user,args --sort -%mem >> /tmp/processes.txt
	mail -s "*NOTICE* "$hostname"  Low Memory" $email < /tmp/processes.txt
fi
