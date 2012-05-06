#!/bin/sh

###
# Noel Barrachina Alonso
###

###
# Script used in the post-install to remove the firmware password from the machine. 
#
# THIS IS UNINSTALLER.VERSION.1.0
###
 
# Define the variable
setregproptool="/Library/Scripts/mycompany/setregproptool"

# Setting the password to blank WILL TAKE EFFECT AFTER REBOOT
$setregproptool -p "" -o "PassworD"
sleep 1

# Disable the prompt for password. New models need this
$setregproptool -d -o "PassworD"

# Logging
echo "Firmware password now set to blank and prompt disabled, reboot for the changes to take effect!" >> /var/log/system.log

#forget that the password was ever installed
pkgutil --forget com.mycompany.pkg.firm.pass.1.0

#Securely removes the firmware tool
srm /Library/Scripts/mycompany/setregproptool

exit 0