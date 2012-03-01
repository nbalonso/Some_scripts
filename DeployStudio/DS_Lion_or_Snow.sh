#!/bin/sh

MEMORY=`system_profiler SPHardwareDataType | grep "Memory" | awk '{ print $2; }'`
PROCESSOR=`system_profiler SPHardwareDataType | grep "Processor Name"`

if [ $MEMORY -ge 2 ]; then
    #we have enough memory
    if [[ "$PROCESSOR" == *i7* ]]; then 
		echo "RuntimeSelectWorkflow: Lion for this guy!"
		exit 0
	fi
	if [[ "$PROCESSOR" == *i5* ]]; then 
		echo "RuntimeSelectWorkflow: Lion for this guy!"
		exit 0
	fi
	if [[ "$PROCESSOR" == *i3* ]]; then 
		echo "RuntimeSelectWorkflow: Lion for this guy!"
		exit 0
	fi
	if [[ "$PROCESSOR" == *Xeon* ]]; then 
		echo "RuntimeSelectWorkflow: Lion for this guy!"
		exit 0
	fi
	if [[ "$PROCESSOR" == *"2 Duo"* ]]; then 
		echo "RuntimeSelectWorkflow: Lion for this guy!"
		exit 0
	fi

	#didnt found a valid processor even though we have enough memory
	echo "RuntimeSelectWorkflow: Snow Leopard for this guy!"
	exit 0	
else
	#we do not have enough memory
	echo "RuntimeSelectWorkflow: Snow Leopard for this guy!"
	exit 0
fi
echo "Script ended abnormally"
exit 1