#!/usr/bin/python
# jss_api_creates_site.py
# Creates a new site with the name of the first argument, and a smart group in
# that site for Yosemite systems

import base64
import urllib2
import json
from xml.dom import minidom
from optparse import OptionParser

## Variables
jss_username = 'username'
jss_password = 'password'
jss_url = 'https://jssserver.nbalonso.com:8443'
##

#Source: http://macbrained.org/the-jss-rest-api-for-everyone/
def call(resource, method = '', data = None):
    request = urllib2.Request(resource)
    request.add_header('Authorization', 'Basic ' + base64.b64encode(jss_username + ':' + jss_password))
    if method.upper() in ('POST', 'PUT', 'DELETE'):
        request.get_method = lambda: method

    if method.upper() in ('POST', 'PUT') and data:
        request.add_header('Content-Type', 'text/xml')
        return urllib2.urlopen(request, data)
    else:
        return urllib2.urlopen(request)

##Parse the arguments
parser = OptionParser(usage="usage: %prog NewSiteName")
(options, args) = parser.parse_args()

if len(args) != 1:
    parser.error("Missing the new site name")
    exit(-1)

new_site_name = str(args[0])

##Getting the last valid site id
response = minidom.parse(call(jss_url+'/JSSResource/sites', 'get'))
sitelist = response.getElementsByTagName('id')
last_known_id = sitelist[-1].firstChild.nodeValue

##Writing new site
next_valid_site_id = int(last_known_id) +1
siteXML='<site><id></id><name>' + new_site_name + '</name></site>'
call(jss_url+'/JSSResource/sites/id/2', 'post', siteXML)
print 'done writing new site'

##Writing the SmartGroup to the new site
groupXML='<computer_group><id></id><name>Scripted Smart group for Yosemite in ' + new_site_name + '</name><is_smart>true</is_smart><site><id>' + str(next_valid_site_id) + '</id><name>' + new_site_name + '</name></site><criteria><size>1</size><criterion><name>Operating System</name><priority>0</priority><and_or>and</and_or><search_type>like</search_type><value>10.10</value></criterion></criteria><computers><size>0</size></computers></computer_group>'
call(jss_url+'/JSSResource/computergroups/id/3', 'post', groupXML)
print 'done writing new group'

exit(0)
