#!/bin/bash
os_info=`cat /etc/redhat-release | sed -e 's/ //g' -e 's/Server//g' -e 's/release//g' -e 's/\..*//g'`

if [ $os_info = "RedHatEnterpriseLinux7" ] ; then
        cp -rp rhel7saityum.repo /etc/yum.repos.d/
elif [ $os_info = "CentOSLinux7" ] ; then
        cp -rp centos7saityum.repo /etc/yum.repos.d/
else
        echo "OS info check!!!!!";
        exit 255;
fi
~
