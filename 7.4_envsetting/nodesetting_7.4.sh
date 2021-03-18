#!/bin/bash

##### function #####
function loop_ldap_location {
while : 
do
	case $location in
		r3|R3) break;;
		p1|P1) break;;
		*) echo -n "ldap_location(r3,p1) : ";
		   read location;;
		
	esac
done
}


##### function #####


if [ $# -ne 0 ] ; then
    for option in `echo $*`
    do
        #if [ $option = "silent" ] ; then
            #Select="1"
        #fi
        case $option in
            silent_r3)
                Select="1"
                location="r3";;
            silent_p1)
                Select="1"
                location="p1";;
            *)  echo  "option check..."
                exit 1
        esac

    done
else
    echo "****************************"
    echo "        Node Setting!       "
    echo "****************************"
    echo "Available Setting Select "
    echo " 1. All setting."
    echo " 2. 방화벽 해제"
    echo " 3. Selinux 해제 setup command disable"
    echo " 4. NetworkManager 해제"  
    echo " 5. Host 변경"
    echo " 6. ssh_config 변경"
    echo " 7. 7.4 RPM 설치"
    echo " 8. NIS 설정"
    echo " 9. RSH 설정"
    echo " 10. User profile 설정"
    echo " 11. NTP 설정"
    echo " 12. limit 설정"
    echo " 13. telnet vsftpd 설정"
    echo " 14. ldap 설정"
    echo " 15. collect 설정"
    echo " 16. DNS 설정"
    echo " 17. NFS 마운트 포인트 설정"
    echo " 18. rsyslog 설정"
    echo " 19. abrtd 설정"
    echo " 20. 세팅 확인"
    echo "****************************"
    printf "Enter your selection  "
    read Select
fi


echo " "
path=`pwd`

case $Select in
	1) 

	###### LDAP location ######
	if [ -z $location ] ; then
		loop_ldap_location;
	fi
	###### LDAP location ######

#echo $location
#exit 10
        systemctl stop firewalld
        systemctl disable firewalld
        cp -rpf selinux_config /etc/selinux/config
        setenforce 0
        systemctl stop NetworkManager
        systemctl disable NetworkManager

        systemctl stop libvirtd
        systemctl disable libvirtd
        cp -rp .ssh/ /root
        scp 202.20.183.10:/etc/hosts /etc/hosts

	cp -af /etc/ssh/sshd_config /etc/ssh/sshd_config.org
	sed -e 's/GSSAPIAuthentication\ yes/GSSAPIAuthentication\ no\ #setting\ modify/g' -e 's/UseDNS\ yes/UseDNS\ no\ #setting\ modify/g' /etc/ssh/sshd_config.org > /etc/ssh/sshd_config
	systemctl restart sshd	

        #cp -rp rhel7saityum.repo /etc/yum.repos.d/
	configbin/yum_os.sh
        yum list
        yum install -y motif.x86_64
        yum install -y environment-modules.x86_64
        yum install -y ksh.x86_64
        yum install -y infiniband-diags.x86_64
        yum install -y finger.x86_64
        yum install -y ipmitool.x86_64
        yum install -y nss.x86_64
        yum install -y nss-pam-ldapd.x86_64
        yum install -y pam.x86_64
        yum install -y iftop.x86_64
        yum install -y htop.x86_64
        yum install -y rsh.x86_64
        yum install -y rsh-server.x86_64
        yum install -y libstdc++.i686
        yum install -y lapack.x86_64
        yum install -y lapack-devel.x86_64
        yum install -y texlive.x86_64
        yum install -y sssd.x86_64
        yum install -y nscd.x86_64
        yum install -y xorg-x11-apps.x86_64
        yum install -y gc.x86_64
        yum install -y guile.x86_64
	yum install -y libstdc++.so.5
	yum install -y compat-libstdc++-33.x86_64
	yum install -y mesa-libEGL.i686
	yum install -y zsh.x86_64
	yum install -y xfig.x86_64
	yum install -y libX11.i686
	yum install -y libnotify.i686
	yum install -y glibc-devel.i686
	yum install -y libX11-devel.x86_64
	yum install -y libX11-devel.i686
        yum install -y atlas.i686
        yum install -y atlas.x86_64
        yum install -y atlas-devel.i686
        yum install -y atlas-devel.x86_64
        yum install -y emacs.x86_64
        yum install -y lcms2.x86_64
        yum install -y freeglut.x86_64
	yum install -y freeglut-devel.x86_64
	yum install -y bzip2-devel.x86_64 lzma-sdk457.x86_64 lzma-sdk457-devel.x86_64
        yum install -y freeglut.i686
        yum install -y glew.x86_64
        yum install -y libGLEW.x86_64 
        yum install -y xerces-c.x86_64
        yum install -y file-devel.x86_64
        yum install -y file-devel.i686
	yum install -y libXext.i686 libXext.x86_64 libXext-devel.i686 libXext-devel.x86_64
	yum install -y libSM.x86_64 libSM.i686 libSM-devel.i686 libSM-devel.x86_64
	yum install -y libXt.i686 libXt.x86_64 libXpm.i686 libXpm.x86_64 libXp.i686 libXp.x86_64
	yum install -y webkitgtk
	yum install -y turbojpeg-devel.x86_64
	yum install -y libsndfile-devel.x86_64
	yum install -y screen.x86_64
	yum install -y sox.x86_64 sox-devel.x86_64 libjpeg-turbo-devel.x86_64
	yum install -y libtiff.x86_64 libtiff-devel.x86_64
	yum install -y giflib.x86_64 giflib-devel.x86_64
	yum install -y libpng-devel.x86_64
	yum install -y matio.x86_64 matio-devel.x86_64
	yum install -y libsvm.x86_64 libsvm-devel.x86_64
	yum install -y yasm.x86_64 yasm-devel.x86_64
	yum install -y libXinerama-devel.x86_64
	yum install -y imlib-devel.x86_64
	yum install -y imlib2.x86_64 imlib2-devel.x86_64
	yum install -y libcurl-devel.x86_64
	yum install -y python34-tkinter.x86_64 tkinter.x86_64
	yum install -y tk-devel.x86_64
	yum install -y xclip
	yum install -y xorg-x11-server-Xvfb
	yum install -y mono-web
        #yum install -y unrar.x86_64    # have not
        rpm -ivh rpms/unrar-5.4.5-1.el7.x86_64.rpm
        yum install -y guile-devel.x86_64  guile-devel.i686
        yum install -y apr-util-devel.i686 apr-util-devel.x86_64
        yum install -y atop.x86_64
        yum install -y brasero-libs.i686 brasero-libs.x86_64
        yum install -y dos2unix.x86_64 dos2unix.i686
        yum install -y ftp.x86_64 ftp.i686
        yum install -y gthumb.x86_64 gthumb.i686
        yum install -y imake.x86_64 imake.i686
        yum install -y iptraf-ng.x86_64 iptraf-ng.i686
        yum install -y itstool.noarch
        yum install -y java-1.8.0-openjdk-devel.i686 java-1.8.0-openjdk-devel.x86_64
        yum install -y libxml2-devel.i686 libxml2-devel.x86_64
        yum install -y libxml2-static.x86_64 libxml2-static.i686
        yum install -y mc.x86_64 mc.i686
        yum install -y meld.noarch
        yum install -y perl-Switch.noarch
        yum install -y python-virtualenv.noarch
        yum install -y telnet.x86_64
        yum install -y telnet-server.x86_64
        yum install -y tree.x86_64
        yum install -y vim-X11.x86_64
        yum install -y wireshark-gnome.x86_64
        yum install -y xinetd.x86_64
        yum install -y boost-python.x86_64 boost-python.i686
        yum install -y cmake.x86_64 cmake.i686
        yum install -y eigen3-devel
        yum install -y freeradius-doc.x86_64 freeradius-doc.i686
        yum install -y glances
        yum install -y rubygem-logstash-event
        yum install -y mingw64-cairo
        yum install -y mingw64-dbus
        yum install -y mingw64-harfbuzz
        yum install -y mingw64-libjpeg-turbo
        yum install -y mingw64-openssl
        yum install -y mingw64-postgresql
        yum install -y mingw64-qt5-qmake
        yum install -y mingw64-qt-qmake
        yum install -y alsa-lib-devel.x86_64 alsa-lib-devel.i686
        yum install -y calligra-core.x86_64 calligra-l10n-zh_CN
        yum install -y ghostscript-chinese
        yum install -y ghostscript-chinese-zh_CN
        yum install -y ibus-handwrite
        yum install -y ibus-handwrite-zh_CN
        yum install -y libsqlite3x.x86_64
        yum install -y libsqlite3x-devel
        yum install -y libXv-devel.x86_64 libXv-devel.i686
        yum install -y libyui libyui-devel libyui-ncurses libyui-ncurses-devel ncurses-devel
        yum install -y netpbm.x86_64 netpbm.i686
        yum install -y openblas.x86_64 openblas.i686
        yum install -y openssl-devel.i686 openssl-devel.x86_64
        yum install -y Red_Hat_Enterprise_Linux-Release_Notes-7-zh-CN
        yum install -y xz-compat-libs.i686 xz-compat-libs.x86_64
        yum install -y mono-basic.x86_64 mono-devel.x86_64
        yum install -y infiniband-diags.x86_64
	yum install -y perl-LDAP
	yum install -y libXmu-devel.x86_64
	yum install -y soundtouch-devel.x86_64 eigen3-devel.noarch

	ln -s /usr/lib64/libGLEW.so.1.10.0 /usr/lib64/libGLEW.so.1.13
	ln -s /usr/lib64/libXm.so.4.0.4 /usr/lib64/libXm.so.3
	ln -s /usr/lib64/libudev.so.1 /usr/lib64/libudev.so.0
	#cp -r hpmpi.tar /opt
	#cd /opt
	#tar xvf hpmpi.tar

        rm -rf /etc/sysconfig/network
        echo HOSTNAME=`hostname` >> /etc/sysconfig/network
        echo NETWORKING=yes >> /etc/sysconfig/network

        cp -rp hosts.equiv  /etc/hosts.equiv
        cp -rp .rhosts /root/.rhosts
        cp -rp pam.d/rsh /etc/pam.d/rsh
        cp -rp pam.d/rlogin /etc/pam.d/rlogin
        cp -rp pam.d/rexec /etc/pam.d/rexec
        mv /etc/securetty /etc/securetty.org
        systemctl enable rsh.socket
	systemctl enable rlogin.socket
	systemctl enable rexec.socket
        systemctl restart rsh.socket
	systemctl restart rlogin.socket
	systemctl restart rexec.socket

        cp -rp lsf.sh /etc/profile.d/
        cp -rp lsf.csh /etc/profile.d/
        cp -rp sms.sh /etc/profile.d/
        cp -rp stgpu.sh /etc/profile.d/
        cp -rp stgpu.csh /etc/profile.d/

        cp -rp ntp.conf /etc/ntp.conf
        systemctl enable ntpd
        systemctl restart ntpd
        hwclock --systohc
	ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

        rm -rf /etc/security/limits.conf
        echo "# for MPI memory" >> /etc/security/limits.conf
        echo "*               hard    memlock         unlimited" >> /etc/security/limits.conf
        echo "*               soft    memlock         unlimited" >> /etc/security/limits.conf
        echo "*               soft    stack           unlimited" >> /etc/security/limits.conf
        echo "*               hard    nofile          10240" >> /etc/security/limits.conf
        echo "*               soft    nofile          10240" >> /etc/security/limits.conf
        echo "# End of file" >> /etc/security/limits.conf
        echo "source /csms/conf/profile.csms;/csms/v1/bin/sm_agent start" >> /etc/rc.local
	chmod +x /etc/rc.d/rc.local

        systemctl disable telnet
        systemctl disable vsftpd

	configbin/ldap_location.sh $location
        systemctl stop nscd
        systemctl disable nscd

        systemctl stop collectl
        cd $path/collectl-4.1.2
        ./INSTALL
        systemctl status collectl
        cd $path
        #systemctl restart rdma
        #systemctl enable rdma

        cp -rp resolv.conf /etc/resolv.conf

        cp -rp .modulespath /usr/share/Modules/init/.modulespath
        mkdir /home/sr1
        mkdir /home/sr2
        mkdir /home/sr3
        mkdir /home/sr4
        mkdir /home/sr5
        mkdir /home/sr6
        mkdir /LSF
        mkdir /apps
        mkdir /share_scratch
        mkdir /scratch
        mkdir /project_scratch
        mkdir -p /check/gpu
        chmod -R 1777 /check
        chmod 1777 /scratch

        cp -rup cmd.sh /etc/profile.d
	cp -rup rsyslog.conf /etc/rsyslog.conf
	cp -rup logrotate.conf /etc/logrotate.conf
        source /etc/profile.d/cmd.sh
        systemctl restart rsyslog.service

	cp -af /etc/abrt/abrt-action-save-package-data.conf /etc/abrt/abrt-action-save-package-data.conf.org
        sed -e 's/OpenGPGCheck =\ yes/OpenGPGCheck =\ no/g' -e 's/ProcessUnpackaged =\ no/ProcessUnpackaged =\ yes/g' /etc/abrt/abrt-action-save-package-data.conf.org > /etc/abrt/abrt-action-save-package-data.conf
	;;

	2)
	systemctl stop firewalld
	systemctl disable firewalld
	;;

	3)
	cp -rpf selinux_config /etc/selinux/config
	setenforce 0
	;;

	4)
	systemctl stop NetworkManager
	systemctl disable NetworkManager
	
	systemctl stop libvirtd
	systemctl disable libvirtd
	;;

	5)
	cp -rp .ssh/ /root
	scp 202.20.183.10:/etc/hosts /etc/hosts
	;;

	6)
	cp -af /etc/ssh/sshd_config /etc/ssh/sshd_config.org
	sed -e 's/GSSAPIAuthentication\ yes/GSSAPIAuthentication\ no\ #setting\ modify/g' -e 's/UseDNS\ yes/UseDNS\ no\ #setting\ modify/g' /etc/ssh/sshd_config.org > /etc/ssh/sshd_config
	systemctl restart sshd	
	;;

	7)
        #cp -rp rhel7saityum.repo /etc/yum.repos.d/
	configbin/yum_os.sh
        yum list
        yum install -y motif.x86_64
        yum install -y environment-modules.x86_64
        yum install -y ksh.x86_64
        yum install -y infiniband-diags.x86_64
        yum install -y finger.x86_64
        yum install -y ipmitool.x86_64
        yum install -y nss.x86_64
        yum install -y nss-pam-ldapd.x86_64
        yum install -y pam.x86_64
        yum install -y iftop.x86_64
        yum install -y htop.x86_64
        yum install -y rsh.x86_64
        yum install -y rsh-server.x86_64
        yum install -y libstdc++.i686
        yum install -y lapack.x86_64
        yum install -y lapack-devel.x86_64
        yum install -y texlive.x86_64
        yum install -y nscd.x86_64
        yum install -y sssd.x86_64
        yum install -y xorg-x11-apps.x86_64
        yum install -y gc.x86_64
        yum install -y guile.x86_64
        yum install -y libstdc++.so.5
        yum install -y compat-libstdc++-33.x86_64
        yum install -y mesa-libEGL.i686
	yum install -y zsh.x86_64
	yum install -y xfig.x86_64
	yum install -y libX11.i686
	yum install -y libnotify.i686
	yum install -y glibc-devel.i686
        yum install -y libX11-devel.x86_64
        yum install -y libX11-devel.i686
        yum install -y atlas.i686
        yum install -y atlas.x86_64
        yum install -y atlas-devel.i686
        yum install -y atlas-devel.x86_64
        yum install -y emacs.x86_64
        yum install -y lcms2.x86_64
        yum install -y freeglut.x86_64
        yum install -y freeglut.i686
        yum install -y glew.x86_64
        yum install -y libGLEW.x86_64 
        yum install -y xerces-c.x86_64
        yum install -y file-devel.x86_64
        yum install -y file-devel.i686
        yum install -y libXext.i686 libXext.x86_64 libXext-devel.i686 libXext-devel.x86_64
        yum install -y libSM.x86_64 libSM.i686 libSM-devel.i686 libSM-devel.x86_64
	yum install -y libXt.i686 libXt.x86_64 libXpm.i686 libXpm.x86_64 libXp.i686 libXp.x86_64
	yum install -y webkitgtk
	yum install -y turbojpeg-devel.x86_64
	yum install -y libsndfile-devel.x86_64
	yum install -y screen.x86_64
        yum install -y sox.x86_64 sox-devel.x86_64 libjpeg-turbo-devel.x86_64
        yum install -y libtiff.x86_64 libtiff-devel.x86_64
        yum install -y giflib.x86_64 giflib-devel.x86_64
        yum install -y libpng-devel.x86_64
        yum install -y matio.x86_64 matio-devel.x86_64
        yum install -y libsvm.x86_64 libsvm-devel.x86_64
        yum install -y yasm.x86_64 yasm-devel.x86_64
        yum install -y libXinerama-devel.x86_64
        yum install -y imlib-devel.x86_64
        yum install -y imlib2.x86_64 imlib2-devel.x86_64
        yum install -y libcurl-devel.x86_64
	yum install -y python34-tkinter.x86_64 tkinter.x86_64
	yum install -y tk-devel.x86_64
	yum install -y xclip
	yum install -y xorg-x11-server-Xvfb
	yum install -y mono-web
	#yum install -y unrar.x86_64	# have not
	rpm -ivh rpms/unrar-5.4.5-1.el7.x86_64.rpm
	yum install -y guile-devel.x86_64  guile-devel.i686
	yum install -y apr-util-devel.i686 apr-util-devel.x86_64
	yum install -y atop.x86_64
	yum install -y brasero-libs.i686 brasero-libs.x86_64
	yum install -y dos2unix.x86_64 dos2unix.i686
	yum install -y ftp.x86_64 ftp.i686
	yum install -y gthumb.x86_64 gthumb.i686
	yum install -y imake.x86_64 imake.i686
	yum install -y iptraf-ng.x86_64 iptraf-ng.i686
	yum install -y itstool.noarch
	yum install -y java-1.8.0-openjdk-devel.i686 java-1.8.0-openjdk-devel.x86_64
	yum install -y libxml2-devel.i686 libxml2-devel.x86_64
	yum install -y libxml2-static.x86_64 libxml2-static.i686
	yum install -y mc.x86_64 mc.i686
	yum install -y meld.noarch
	yum install -y perl-Switch.noarch
	yum install -y python-virtualenv.noarch
	yum install -y telnet.x86_64
	yum install -y telnet-server.x86_64
	yum install -y tree.x86_64
	yum install -y vim-X11.x86_64
	yum install -y wireshark-gnome.x86_64
	yum install -y xinetd.x86_64
	yum install -y boost-python.x86_64 boost-python.i686
	yum install -y cmake.x86_64 cmake.i686
	yum install -y eigen3-devel
	yum install -y freeradius-doc.x86_64 freeradius-doc.i686
	yum install -y glances
	yum install -y rubygem-logstash-event
	yum install -y mingw64-cairo
	yum install -y mingw64-dbus
	yum install -y mingw64-harfbuzz
	yum install -y mingw64-libjpeg-turbo
	yum install -y mingw64-openssl
	yum install -y mingw64-postgresql
	yum install -y mingw64-qt5-qmake
	yum install -y mingw64-qt-qmake
	yum install -y alsa-lib-devel.x86_64 alsa-lib-devel.i686
	yum install -y calligra-core.x86_64 calligra-l10n-zh_CN
	yum install -y ghostscript-chinese
	yum install -y ghostscript-chinese-zh_CN
	yum install -y ibus-handwrite
	yum install -y ibus-handwrite-zh_CN
	yum install -y libsqlite3x.x86_64
	yum install -y libsqlite3x-devel
	yum install -y libXv-devel.x86_64 libXv-devel.i686
	yum install -y libyui libyui-devel libyui-ncurses libyui-ncurses-devel ncurses-devel
	yum install -y netpbm.x86_64 netpbm.i686
	yum install -y openblas.x86_64 openblas.i686
	yum install -y openssl-devel.i686 openssl-devel.x86_64
	yum install -y Red_Hat_Enterprise_Linux-Release_Notes-7-zh-CN
	yum install -y xz-compat-libs.i686 xz-compat-libs.x86_64
	yum install -y mono-basic.x86_64 mono-devel.x86_64
	yum install -y infiniband-diags.x86_64
	yum install -y perl-LDAP
	yum install -y libXmu-devel.x86_64
	yum install -y soundtouch-devel.x86_64 eigen3-devel.noarch


	ln -s /usr/lib64/libGLEW.so.1.10.0 /usr/lib64/libGLEW.so.1.13
        ln -s /usr/lib64/libXm.so.4.0.4 /usr/lib64/libXm.so.3
	ln -s /usr/lib64/libudev.so.1 /usr/lib64/libudev.so.0

	;;

	8)
	rm -rf /etc/sysconfig/network
      	echo HOSTNAME=`hostname` >> /etc/sysconfig/network
      	echo NETWORKING=yes >> /etc/sysconfig/network
	;;

	9)
	cp -rp hosts.equiv  /etc/hosts.equiv
	cp -rp .rhosts /root/.rhosts
	cp -rp pam.d/rsh /etc/pam.d/rsh
	cp -rp pam.d/rlogin /etc/pam.d/rlogin
	cp -rp pam.d/rexec /etc/pam.d/rexec
	mv /etc/securetty /etc/securetty.org
        systemctl enable rsh.socket
        systemctl enable rlogin.socket
        systemctl enable rexec.socket
        systemctl restart rsh.socket
        systemctl restart rlogin.socket
        systemctl restart rexec.socket
	;;


	10)
	cp -rp lsf.sh /etc/profile.d/
	cp -rp lsf.csh /etc/profile.d/
	cp -rp sms.sh /etc/profile.d/
	cp -rp stgpu.sh /etc/profile.d/
	cp -rp stgpu.csh /etc/profile.d/
	;;

	11)
	cp -rp ntp.conf /etc/ntp.conf
	systemctl enable ntpd
	systemctl restart ntpd
	hwclock --systohc
	ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
	;;

	12)
	rm -rf /etc/security/limits.conf
	echo "# for MPI memory" >> /etc/security/limits.conf
	echo "*               hard    memlock         unlimited" >> /etc/security/limits.conf
	echo "*               soft    memlock         unlimited" >> /etc/security/limits.conf
	echo "*               soft    stack           unlimited" >> /etc/security/limits.conf
	echo "*               hard    nofile          10240" >> /etc/security/limits.conf
	echo "*               soft    nofile          10240" >> /etc/security/limits.conf
	echo "# End of file" >> /etc/security/limits.conf
	echo "source /csms/conf/profile.csms;/csms/v1/bin/sm_agent start" >> /etc/rc.local
	chmod +x /etc/rc.d/rc.local
	;;

	13)
	systemctl disable telnet
	systemctl disable vsftpd
	;;

	14)
	###### LDAP location ######
	if [ $# -eq 0 ] ; then
		loop_ldap_location;
	elif [ $* = "r3" ] || [ $* = "R3" ] ; then
		location=r3;
	elif [ $* = "p1" ] || [ $* = "P1" ] ; then
		location=p1;
	else
		loop_ldap_location;
	fi
	###### LDAP location ######
	configbin/ldap_location.sh $location
        systemctl stop nscd
        systemctl disable nscd
	;;

	15)
	systemctl stop collectl
	cd $path/collectl-4.1.2
	./INSTALL
	systemctl status collectl
	collectl -s+x
	cd $path 
	#systemctl restart rdma
	#systemctl enable rdma
	;;

	16) cp -rp resolv.conf /etc/resolv.conf
	;;

	17)
	cp -rp .modulespath /usr/share/Modules/init/.modulespath
        mkdir /home/sr1
        mkdir /home/sr2
        mkdir /home/sr3
        mkdir /home/sr4
        mkdir /home/sr5
        mkdir /home/sr6
        mkdir /LSF
        mkdir /apps
        mkdir /share_scratch
        mkdir /scratch
        mkdir /project_scratch
        mkdir -p /check/gpu
	chmod -R 1777 /check
        chmod 1777 /scratch
	;;

	18)
        cp -rup cmd.sh /etc/profile.d
        cp -rup cmd.sh /etc/profile.d
        cp -rup rsyslog.conf /etc/rsyslog.conf
        cp -rup logrotate.conf /etc/logrotate.conf
        source /etc/profile.d/cmd.sh
        systemctl restart rsyslog.service
	;;
	
	19)
	cp -af /etc/abrt/abrt-action-save-package-data.conf /etc/abrt/abrt-action-save-package-data.conf.org
        sed -e 's/OpenGPGCheck =\ yes/OpenGPGCheck =\ no/g' -e 's/ProcessUnpackaged =\ no/ProcessUnpackaged =\ yes/g' /etc/abrt/abrt-action-save-package-data.conf.org > /etc/abrt/abrt-action-save-package-data.conf
	;;

	20)
	echo "*******************************************************************************"
	echo -ne "\\033[1;34m                                 firewalld check                 \\033[0m\n"
	check=`systemctl list-unit-files firewalld.service | grep service | awk '{print $2}'`
	if [ $check == "disabled" ]
	then
	echo -ne "\\033[1;33m 1. Disable Service --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	else
	echo -ne "\\033[1;33m 1. Disable Service --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	fi
	check=`systemctl status firewalld | grep Active | awk '{print $2}'`
	if [ $check == "inactive" ]
	then
	echo -ne "\\033[1;33m 2. Stop Daemon --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	else
	echo -ne "\\033[1;33m 2. Stop Daemon --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	fi
	echo "*******************************************************************************"
	echo " "
	echo "*******************************************************************************"
	echo -ne "\\033[1;34m                                 selinux check                 \\033[0m\n"
	check=`sestatus |  awk  '{print $3}'`
	if [ $check == "disabled" ]
	then
	echo -ne "\\033[1;33m 1. Stop Daemon --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	else
	echo -ne "\\033[1;33m 1. Stop Daemon --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	fi
	echo "*******************************************************************************"
	echo " "
	echo "*******************************************************************************"
	echo -ne "\\033[1;34m                                 NetworkManager check                 \\033[0m\n"
	check=`systemctl list-unit-files NetworkManager.service | grep service | awk '{print $2}'`
	if [ $check == "disabled" ]
	then
	echo -ne "\\033[1;33m 1. Disable Service --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	else
	echo -ne "\\033[1;33m 1. Disable Service --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	fi
	check=`systemctl status NetworkManager | grep Active | awk '{print $2}'`
	if [ $check == "inactive" ]
	then
	echo -ne "\\033[1;33m 2. Stop Daemon --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	else
	echo -ne "\\033[1;33m 2. Stop Daemon --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	fi
	echo "*******************************************************************************"
	echo " "
	#echo "*******************************************************************************"
	#echo -ne "\\033[1;34m                                 NIS check                 \\033[0m\n"
	#check=`cat /etc/sysconfig/network | grep NISDOMAIN`

	#if [ $check != "" ]
	#then
	#echo -ne "\\033[1;33m 1. /etc/sysconfig/network --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	#else
	#echo -ne "\\033[1;33m 1. /etc/sysconfig/network --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	#fi
	#check=`cat /etc/host.conf | grep order | awk '{print $1}'`

	#if [ $check != " " ]
	#then
	#echo -ne "\\033[1;33m 2. /etc/host.conf --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	#else
	#echo -ne "\\033[1;33m 2. /etc/host.conf --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	#fi

	#check=`cat /etc/yp.conf | grep -v '#' | awk '{print $1}' | head -n 1`
	#if [ $check != " " ]
	#then
	#echo -ne "\\033[1;33m 3. /etc/yp.conf --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	#else
	#echo -ne "\\033[1;33m 3. /etc/yp.conf --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	#fi

	#check=`cat /etc/nsswitch.conf | grep passwd | grep -v '#' | awk '{print $4}'`
	#check1=`cat /etc/nsswitch.conf | grep shadow | grep -v '#' | awk '{print $4}'`
	#check2=`cat /etc/nsswitch.conf | grep group | grep -v '#' | awk '{print $4}'`
	#check3=`cat /etc/nsswitch.conf | grep hosts | grep -v '#' | awk '{print $4}'`
	#if [ $check == "ldap" and $check1 == "ldap" and $check2 == "ldap" $check3 == "ldap" ]
	#then
	#echo -ne "\\033[1;33m 4. /etc/nsswitch.conf --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	#else
	#echo -ne "\\033[1;33m 4. /etc/nsswitch.conf --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	#fi
	
	#check=`chkconfig --list | grep ypbind | awk  '{print $5}' | cut -c 4`
	#if [ $check != f ]
	#then
	#echo -ne "\\033[1;33m 1. chkconfig --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	#else
	#echo -ne "\\033[1;33m 1. chkconfig --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	#fi
	#check=`service ypbind status |  awk '{print $4}'`
	#if [ $check != not ]
	#then
	#echo -ne "\\033[1;33m 2. daemon --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	#else
	#echo -ne "\\033[1;33m 2. daemon --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	#fi

	echo "*******************************************************************************"
	echo -ne "\\033[1;34m                                 ldap check                 \\033[0m\n"
	check=`cat /etc/sssd/sssd.conf | grep domains | awk '{print $3}'`
	if [ $check != "" ]
	then
	echo -ne "\\033[1;33m 1. /etc/sssd/sssd.conf --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	else
	echo -ne "\\033[1;33m 1. /etc/sssd/sssd.conf --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	fi
	check=`ls -l /etc/sssd/sssd.conf | awk '{print $1}'`
	if [ $check == "-rw-------" ]
	then
	echo -ne "\\033[1;33m 2. chmod 600 sssd.conf --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"
        else
        echo -ne "\\033[1;33m 2. chmod 600 sssd.conf --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"
        fi
        check=`systemctl status sssd | grep Active | awk '{print $2}'`
        if [ $check == "active" ]
        then
        echo -ne "\\033[1;33m 3. Start Daemon --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"
        else
        echo -ne "\\033[1;33m 3. Start Daemon --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"
        fi
        check=`systemctl list-unit-files sssd.service | grep service | awk '{print $2}'`
        if [ $check == "enabled" ]
        then
        echo -ne "\\033[1;33m 4. Enable Service --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"
        else
        echo -ne "\\033[1;33m 4. Enable Service --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"
        fi


	echo "*******************************************************************************"
	echo "" 
	echo "*******************************************************************************"
	echo -ne "\\033[1;34m                                 RSH check                 \\033[0m\n"

	check=`cat /etc/pam.d/rsh | grep -e '#' | grep auth | awk '{print $1}'`
	check1=`cat /etc/pam.d/rlogin | grep -e '#' | grep auth | awk '{print $1}'`
	check2=`cat /etc/pam.d/rexec | grep -e '#' | grep auth | awk '{print $1}'`
	if [ $check == "#auth" and $check1 == "#auth" and $check2 == "#auth" ]
	then
	echo -ne "\\033[1;33m 1. /etc/pam.d --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	else
	echo -ne "\\033[1;33m 1. /etc/pam.d --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	fi

	#echo "*******************************************************************************"
	#echo "" 
	#echo "*******************************************************************************"
	#echo -ne "\\033[1;34m                                 xinetd check                 \\033[0m\n"

	#check=`cat /etc/xinetd.d/rsh | grep disable | awk '{print $1}'`
	#check1=`cat /etc/xinetd.d/rlogin | grep disable | awk '{print $1}'`
	#check2=`cat /etc/xinetd.d/rexec | grep disable | awk '{print $1}'`
	#if [ $check == "disable" and $check1 == "disable" and $check2 == "disable" ]
	#then
	#echo -ne "\\033[1;33m 1. /etc/xinetd.d --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	#else
	#echo -ne "\\033[1;33m 1. /etc/xinetd.d --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	#fi

	echo "*******************************************************************************"
	echo "" 
	echo "*******************************************************************************"
	echo -ne "\\033[1;34m                                 FTA check                 \\033[0m\n"

	check=`cat /etc/services | grep -e '#' | grep soap-beep | awk '{print $1}' | head -1`
	check1=`cat /etc/services | grep FTA | awk '{print $1}'`
	if [ $check == "#soap-beep" and $check1 == "fta" ]
	then
	echo -ne "\\033[1;33m 1. /etc/services --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	else
	echo -ne "\\033[1;33m 1. /etc/services --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	fi

	echo "*******************************************************************************"
	echo "" 
	echo "*******************************************************************************"
	echo -ne "\\033[1;34m                                 NTP check                 \\033[0m\n"

	check=`systemctl list-unit-files ntpd.service | grep service | awk '{print $2}'`
	if [ $check == "enabled" ]
	then
	echo -ne "\\033[1;33m 1. Enable Service --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	else
	echo -ne "\\033[1;33m 1. Enable Service --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	fi
	check=`systemctl status ntpd | grep Active | awk '{print $2}'`
	if [ $check == "active" ]
	then
	echo -ne "\\033[1;33m 2. Start Daemon --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	else
	echo -ne "\\033[1;33m 2. Start Daemon --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	fi

	echo "*******************************************************************************"
	echo "" 
	echo "*******************************************************************************"
	echo -ne "\\033[1;34m                                 limit check                 \\033[0m\n"

	echo -ne "\\033[1;33m 1. /etc/security/limits.conf \\033[0m\n"
	echo -ne "\\033[1;31m`cat /etc/security/limits.conf | grep -v '#'` \\033[0m\n"

	echo "*******************************************************************************"
	echo "" 
	echo "*******************************************************************************"
	echo -ne "\\033[1;34m                                 telnet/vsftpd check                 \\033[0m\n"

	check=`chkconfig --list | grep telnet | grep -v ek | grep -v kr | awk '{print $2}'`
	if [ $check == "on" ]
	then
	echo -ne "\\033[1;33m 1. chkconfig --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	else
	echo -ne "\\033[1;33m 1. chkconfig --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	fi

	check=`chkconfig --list | grep vsftpd | awk '{print $5}' | cut -c 4`
	if [ $check == "n" ]
	then
	echo -ne "\\033[1;33m 1. chkconfig --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	else
	echo -ne "\\033[1;33m 1. chkconfig --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	fi


	echo "*******************************************************************************"
	echo "" 
	echo "*******************************************************************************"
	echo -ne "\\033[1;34m                             RHEL6.4 setting check                 \\033[0m\n"

	check=`cat /etc/idmapd.conf | grep Domain | grep -v '#' | awk '{print $1}'`
	if [ $check == Domain ]
	then
	echo -ne "\\033[1;33m 1. /etc/idmapd.conf --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	else
	echo -ne "\\033[1;33m 1. /etc/idmapd.conf --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	fi

	check=`chkconfig --list | grep rdma | awk '{print $5}' | cut -c 4`
	if [ $check != f ]
	then
	echo -ne "\\033[1;33m 2. chkconfig --> \\033[0m \\033[1;31m [ OK ] \\033[0m\n"  
	else
	echo -ne "\\033[1;33m 2. chkconfig --> \\033[0m \\033[1;31m [ FALSE ] \\033[0m\n"  
	fi

	echo -ne "\\033[1;33m 3. rdma damon \\033[0m\n"
	echo -ne "\\033[1;31m `service rdma status` \\033[0m\n"
	;;
esac
