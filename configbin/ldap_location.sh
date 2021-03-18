#!/bin/bash

function ldap_location {
while :
do
        case $location in
                R3|r3|"")
                   cp -a sssd.conf.template_r3 /etc/sssd/sssd.conf
                   cp -rp nsswitch.conf /etc/nsswitch.conf
                   chmod 600 /etc/sssd/sssd.conf
                   authconfig --disablenis --enableldap --enableldapauth --ldapserver="202.20.185.110,202.20.183.110,202.20.185.11" --ldapbasedn="dc=supercom,dc=samsung" --enablerfc2307bis --disableldaptls --enablesssd --enablesssdauth --enableforcelegacy --updateall
                   echo "idle_timelimit 90" >> /etc/nslcd.conf
                   systemctl restart nscd
                   systemctl enable nscd
                   systemctl restart sssd
                   systemctl enable sssd
                        break;;
                P1|p1)
                   cp -a sssd.conf.template_p1 /etc/sssd/sssd.conf
                   cp -rp nsswitch.conf /etc/nsswitch.conf
                   chmod 600 /etc/sssd/sssd.conf
                   authconfig --disablenis --enableldap --enableldapauth --ldapserver="75.23.159.1,75.23.159.2,202.20.185.11" --ldapbasedn="dc=supercom,dc=samsung" --enablerfc2307bis --disableldaptls --enablesssd --enablesssdauth --enableforcelegacy --updateall
                   echo "idle_timelimit 90" >> /etc/nslcd.conf
                   systemctl restart nscd
                   systemctl enable nscd
                   systemctl restart sssd
                   systemctl enable sssd
                        break;;
                *)
                        echo "location missing(r3,p1)"
                        return;;
        esac
done
}

if [ $# -eq 0 ] ; then
        echo -n "ldap_location : ";
        read location;
        ldap_location;
else
        for location in $*; do
                ldap_location;
        done
fi
