#!/bin/bash
#radiusfree
sudo yum -y update
sudo yum -y install freeradius freeradius-utils freeradius-mysql freeradius-perl 
if [ $? -ne 0 ]; then 
 echo "Cannot install radius Exiting..."
	exit 1
else
	echo "radius has been installed."
fi
systemctl start radiusd.service
if [ $? -ne 0 ]; then 
 echo "cannot been start radius"
 exit 1
fi
systemctl enable radiusd.service
if [ $? -ne 0 ]; then 
 echo "cannot been enable radius"
 exit 1
fi
systemctl status radiusd.service
systemctl enable firewalld
if [ $? -ne 0 ]; then 
 echo "cannot been enable firewalld"
 exit 1
fi
systemctl start firewalld
if [ $? -ne 0 ]; then 
 echo "cannot been start firewalld"
 exit 1
fi
firewall-cmd --add-service={http,https,radius} --permanent
firewall-cmd --reload
firewall-cmd --get-default --zone=public
firewall-cmd --list-services --zone=public
dhcpv6-client http https radius ssh
pkill radius
radiusd -X
