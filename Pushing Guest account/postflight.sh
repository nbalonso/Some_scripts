#!/bin/bash

#variables
dscl="/usr/bin/dscl"
security="/usr/bin/security"

echo "`date` INFO: starting lguest creation" >> /var/log/system.log
sleep 1

#Check if lguest already exists
if [ -f /var/db/dslocal/nodes/Default/users/lguest.plist ]; then
	echo "INFO: lguest was found on the system" >> /var/log/system.log
	echo "INFO: nothing done" >> /var/log/system.log
	echo "INFO: Exiting now" >> /var/log/system.log
	exit 0
else
	#simple version checking
	if [ "`sw_vers | grep -o 10.6`" != "" ]; then 
		echo "INFO: executing the 10.6 version of the script" >> /var/log/system.log
		$dscl . -create /Users/lguest 2>/dev/null
		$dscl . -create /Users/lguest UserShell /bin/bash 2>/dev/null
		$dscl . -create /Users/lguest RealName "Local Account" 2>/dev/null
		$dscl . -create /Users/lguest UniqueID 201 2>/dev/null
		$dscl . -create /Users/lguest PrimaryGroupID 201 2>/dev/null
		$dscl . -create /Users/lguest NFSHomeDirectory /Users/Guest 2>/dev/null
		$dscl . -create /Users/lguest RecordType dsRecTypeStandard:Users 2>/dev/null
		$dscl . -create /Users/lguest dsAttrTypeNative:_defaultLanguage en 2>/dev/null
		$dscl . -create /Users/lguest dsAttrTypeNative:_guest true 2>/dev/null
		$dscl . -create /Users/lguest dsAttrTypeNative:_writers__defaultLanguage Guest 2>/dev/null
		$dscl . -create /Users/lguest dsAttrTypeNative:_writers_jpegphoto Guest 2>/dev/null
		$dscl . -create /Users/lguest dsAttrTypeNative:_writers_LinkedIdentity Guest 2>/dev/null
		$dscl . -create /Users/lguest dsAttrTypeNative:_writers_picture Guest 2>/dev/null
		$dscl . -create /Users/lguest dsAttrTypeNative:_writers_UserCertificate Guest 2>/dev/null
		$dscl . -create /Users/lguest AppleMetaNodeLocation /Local/Default 2>/dev/null
		sleep 2
		#setting up an empty password and giving local Kerberos some time to process it
		$dscl . -passwd /Users/lguest '' 2>/dev/null
		#logging in console
		echo "INFO: lguest should be created now" >> /var/log/system.log
		echo "INFO: Exiting now" >> /var/log/system.log
		exit 0
	fi
	
	if [ "`sw_vers | grep -o 10.7`" != "" ]; then 	
		echo "INFO: executing the 10.7 version of the script" >> /var/log/system.log
		$dscl . -create /Users/lguest 2>/dev/null
		$dscl . -create /Users/lguest dsAttrTypeNative:_defaultLanguage en 2>/dev/null
		$dscl . -create /Users/lguest dsAttrTypeNative:_guest true 2>/dev/null
		$dscl . -create /Users/lguest dsAttrTypeNative:_writers__defaultLanguage Guest 2>/dev/null		
		$dscl . -create /Users/lguest dsAttrTypeNative:_writers_LinkedIdentity Guest 2>/dev/null		
		$dscl . -create /Users/lguest dsAttrTypeNative:_writers_UserCertificate Guest 2>/dev/null		
		$dscl . -create /Users/lguest AuthenticationHint '' 2>/dev/null
		$dscl . -create /Users/lguest NFSHomeDirectory /Users/Guest 2>/dev/null
		#setting up an empty password and giving local Kerberos some time to process it
		sleep 2
		$dscl . -passwd /Users/lguest '' 2>/dev/null
		sleep 2
		$dscl . -create /Users/lguest Picture "/Library/User Pictures/Nature/Leaf.tif" 2>/dev/null
		$dscl . -create /Users/lguest PrimaryGroupID 201 2>/dev/null
		$dscl . -create /Users/lguest RealName "Local Guest" 2>/dev/null
		$dscl . -create /Users/lguest RecordName lguest 2>/dev/null
		#Lion does not like two users with same UUID so don't use 201 on the next line
		$dscl . -create /Users/lguest UniqueID 401 2>/dev/null
		$dscl . -create /Users/lguest UserShell /bin/bash 2>/dev/null
		#Adding the keychain item that allows Guest to login in 10.7
		$security add-generic-password -a lguest -s com.apple.loginwindow.guest-account -D "application password" /Library/Keychains/System.keychain
		#logging in console
		echo "INFO: lguest should be created now" >> /var/log/system.log
		echo "INFO: Exiting now" >> /var/log/system.log
		exit 0
	fi
	
	echo "ERROR: Operating system version not supported by this script" >> /var/log/system.log
	echo "INFO: Exiting now" >> /var/log/system.log
fi
exit -1