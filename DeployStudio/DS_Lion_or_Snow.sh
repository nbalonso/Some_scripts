#!/bin/sh

MEMORY=`system_profiler SPHardwareDataType | grep "Memory" | awk '{ print $2; }'`
PROCESSOR=`system_profiler SPHardwareDataType | grep "Processor Name"`

if [ $MEMORY -ge 2 ]; then
    #echo "we have enough memory"
    if [[ "$PROCESSOR" == *i7* ]]; then 
		echo "RuntimeSelectWorkflow: Lion for this guy!"
		exit 0
	fi
	if [[ "$PROCESSOR" == *i3* ]]; then 
		echo "RuntimeSelectWorkflow: Lion for this guy!"
		exit 0
	fi
	#
	#
	#more cpu checks here
	#
	#
	echo "RuntimeSelectWorkflow: Snow Leopard for this guy!"
	exit 0	
else
	#echo "we do not have enough memory"
	echo "RuntimeSelectWorkflow: Snow Leopard for this guy!"
fi