#!/usr/bin/python
# jss_api_collect_ssh_keys.py
# Collects the public ssh keys that we collected in the JSS and generates a
# valid known_hosts file

import sys
from os.path import expanduser
import base64
import urllib2
import json

## Variables
jss_username = 'username'
jss_password = 'password'
jss_url = 'https://jssserver.nbalonso.com:8443'
result_file = expanduser('~/.ssh/known_hosts')

def getAuthHeader():
    # Compute base64 representation of the authentication token.
    token = base64.b64encode('%s:%s' % (jss_username,jss_password))
    return 'Basic %s' % token

def call(resource):
    request = urllib2.Request(resource, headers={'Authorization':getAuthHeader(),'Accept':'application/json'})
    return urllib2.urlopen(request)

computersListJSON = json.load(call(jss_url+'/JSSResource/computers'))['computers']

result = ''
for c in (computersListJSON):
    ext_attrib_url = '/JSSResource/computers/id/' + str(c.get('id')) + '/subset/extensionattributes'
    ext_attrib = json.load(call(jss_url+ext_attrib_url))['computer']['extension_attributes'][0]['value']
    result += ext_attrib
    result += '\n'

# Write to disk
file = open(result_file, 'w+')
file.write(result)
file.close()
exit(0)
