####################################
## RHEL 8.3 TEST OS install&setup ##
####################################


#### ---- OS install info ----
/boot : 1024MiB, ext4
/boot/efi : 1024MiB
swap 	: 32GB or 64 GB, swap 
/		: 나머지, ext4 

- 설치 패키지
Virtualization 제외 모두 체크

- 설치 언어, 시간
Korean, Seoul


#### ---- OS config ----

# set locan Repository (dnf)
mount -t iso9660 /root/iso/rhel-8.3-x86_64-dvd.iso /mnt
mkdir /localrepo
cp -rv /mnt/* /localrepo/
umount /mnt

cat <<EOF > /etc/yum.repos.d/local.repo
[LocalRepo_BaseOS]
name=LocalRepository_BaseOS
baseurl=file:///localrepo/BaseOS
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
[LocalRepo_AppStream]
name=LocalRepository_AppStream
baseurl=file:///localrepo/AppStream
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
EOF

yum clean all
yum update 
yum repolist

# interface name change
vi /etc/default/grub					
	GRUB_CMDLINE_LINUX="crashkernel=auto resume=UUID=6a57f485-53a4-4fb6-825c-21a25415b11a rhgb quiet net.ifnames=0 biosdevname=0" # 해당 라인 quiet 뒷부분에 net.ifnames=0 biosdevname=0 추가
grub2-mkconfig -o /boot/grub2/grub.cfg	#
ifconfig								
cd /etc/sysconfig/network-scripts
mv ./ifcfg-eno1 ./ifcfg-eth0 && mv ./ifcfg-eno2 ./ifcfg-eth1


# set hostname
hostnamectl set-hostname rhel8-test2

#systemctl
systemctl disable firewalld --now

systemctl disable libvird.service --now
ifdown virbr0

systemctl enable rdma --now


#SELINUX config
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
setenforce 0


#set timezone (chrony)

sed -i 's/pool 2.rhel.pool.ntp.org/server 202.20.185.8/g' /etc/chrony.conf
systemctl start chronyd
systemctl enable chronyd

timedatectl set-ntp yes
or
chronyc -a makestep

timedatectl #동기화 확인


# set network
modprobe bonding
lsmod | grep bonding

# bond0 - Master
cat <<EOF > ifcfg-bond0
TYPE=bond
BOOTPROTO=none
DEFROUTE=yes
IPV6INIT=no
DEVICE=bond0
ONBOOT=yes
BONDING_MASTER=yes
BONDING_OPTS="mode=4 miimon=100"
PREFIX=24
IPADDR=202.20.204.80
GATEWAY=202.20.204.254
EOF

# slave
cat <<EOF > ifcfg-eth0
TYPE=Ethernet
BOOTPROTO=none
DEFROUTE=yes
IPV6INIT=yes
NAME=eth0
DEVICE=eth0
ONBOOT=yes
MASTER=bond0
SLAVE=yes
EOF

# slave
cat <<EOF > ifcfg-eth1
TYPE=Ethernet
BOOTPROTO=none
DEFROUTE=yes
IPV6INIT=yes
NAME=eth1
DEVICE=eth1
ONBOOT=yes
MASTER=bond0
SLAVE=yes
EOF

nmcli con reload
#or
systemctl restart NetworkManager


#set Infiniband
yum install gcc-gfortran tcsh tk
mount -t iso9660 /root/iso/MLNX_OFED_LINUX-5.1-2.5.8.0-rhel8.3-x86_64.iso /mnt
cd /mnt
./mlnxofedinstall --force --without-fw-update --hpc
umount /mnt

## OFED 설치간 의존성은 yum을 통해 설치
#IB 설정간 서비스 관련 부분 파악전까지 아래 설정으로 연결
# 설정에 영향을 미치는 내용은 주석처리
cat << EOF > ifcfg-ib0
CONNECTED_MODE=no
TYPE=InfiniBand
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=none
IPADDR=192.168.204.80
PREFIX=16
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=ib0
DEVICE=ib0
ONBOOT=yes
EOF

rmmod ib_ipoib
modprobe ib_ipoib
nmcli up ib0

systemctl restart NetworkManager

## set used nmcli

#nmcli con add con-name ib0 type infiniband ip4 192.168.204.80/16
#nmcli con modify ib0 infiniband.mtu 65520 infiniband.transport-mode connected
#rmmod ib_ipoib
#modprobe ib_ipoib
#nmcli up ib0
#nmcli con reload
