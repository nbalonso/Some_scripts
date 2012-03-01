#!/bin/sh

MEMORY=`system_profiler SPHardwareDataType | grep "Memory" | awk '{ print $2; }'`
PROCESSOR=`system_profiler SPHardwareDataType | grep "Processor Name"`

if [ $MEMORY -ge 2 ]; then
        #echo "we have enough memory"
        if [[ "$PROCESSOR" == *i7* ]]; then 
		echo "RuntimeSelectWorkflow: Lion for this guy!"
	fi
	if [[ "$PROCESSOR" == *i3* ]]; then 
		echo "RuntimeSelectWorkflow: Lion for this guy!"
	fi
	.
	.
	#more cpu checks here
	.
	.
	
else
	#echo "we do not have enough memory"
	echo "RuntimeSelectWorkflow: Snow Leopard for this guy!"
fi

exit 0