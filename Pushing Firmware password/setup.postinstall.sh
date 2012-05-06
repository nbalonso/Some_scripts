#!/bin/sh

###
# Noel Barrachina Alonso
###

###
# Script used in the post-install to set up the firmware password. 
#
# THIS IS VERSION.1.0 TO REMOVE IT USE THE UNINSTALLER.VERSION.1.0
###

# Define the variable
setregproptool="/Library/Scripts/mycompany/setregproptool"

# Deactivating the password first
$setregproptool -d -o "PassworD"
sleep 1

# Setting the password and the mode
$setregproptool -m command -p "PassworD" -o "PassworD"

# Logging
echo "The firmware password version.1.0 is now set up!" >> /var/log/system.log

#if the removal was done on this machine forget it, so that Munki can push it back when requested
pkgutil --forget com.mycompany.pkg.firm.pass.remove.1.0 >> /dev/null

#Securely removes the password tool
srm /Library/Scripts/mycompany/setregproptool

exit 0