## Auto Setup Firmware Password ##

I use this two postinstall scripts to set up a password on the computers and remove the passwords the week before the semester ends.

Both are deployed with [Munki](http://code.google.com/p/munki) using the `<key>force_install_after_date</key>`

You can obtain the setregproptool from the `Firmware Password Utility.app` bundle

It probably should be done with the binary file self contained in the package instead of copy and then deleting. But gets the job done (:

Noel