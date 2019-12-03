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
if [ $? -ne 0]; then
 echo "Cannot add"
 exit 1
else
 echo "Succes"
fi 
firewall-cmd --reload
if [ $? -ne 0]; then 
 echo "Error"
 exit 1
fi 
firewall-cmd --get-default --zone=public
if [ $? -ne 0]; then
 echo "error"
 exit 1
else
 echo "Succes"
fi
firewall-cmd --list-services --zone=public
firewall-cmd –zone=public –add-port=1812/udp
if [ $? -ne 0]; then 
 echo "cannot add this port"
 exit 1
else
 echo "succes"
fi
firewall-cmd –zone=public –add-port=1813/udp
if [ $? -ne 0]; then 
 echo "cannot add this port"
 exit 1
else
 echo "succes"
fi
firewall-cmd –zone=public –permanent –add-port=1812/udp
if [ $? -ne 0]; then 
 echo "cannot add this port"
 exit 1
else
 echo "succes"
fi
firewall-cmd –zone=public –permanent –add-port=1813/udp
if [ $? -ne 0]; then 
 echo "cannot add this port"
 exit 1
else
 echo "succes"
fi
firewall-cmd –zone=public –add-service=radius
if [ $? -ne 0]; then 
 echo "cannot add this service"
 exit 1
else
 echo "succes"
fi
firewall-cmd –zone=public –permanent –add-service=radius
if [ $? -ne 0]; then 
 echo "cannot add this service"
 exit 1
else
 echo "succes"
fi
echo " go to etc/raddb after editing client.conf"
 
