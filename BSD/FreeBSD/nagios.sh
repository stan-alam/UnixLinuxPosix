#! /bin/bash


# Script to install nagios plugin and NRPE on nagios clients using downloading and compiling them.



# Step 1 --> Nagios plugins Installation

# add Nagios User with not shell access

useradd -s /sbin/nologin nagios


echo "user Nagios Added" >> /tmp/nagios_plugin_install.log



# Create a direcory at /root/nrpe to hold the Nagios plugin and Nrpe downloads; Download the Nagios Plugins

mkdir /root/nrpe ; cd /root/nrpe



echo "/root/nrpe direcory created " >> /tmp/nagios_plugin_install.log



wget http://prdownloads.sourceforge.net/sourceforge/nagiosplug/nagios-plugins-1.4.16.tar.gz



echo "download of plugin completed " >> /tmp/nagios_plugin_install.log



# Untar the plugin

tar -xvzf nagios-plugins-1.4.14.tar.gz



echo "untar of plugin complted " >> /tmp/nagios_plugin_install.log



# change directory to nagios-plugins

cd nagios-plugins-1.4.14



# configure the Nagios plugin

./configure --with-nagios-user=nagios --with-nagios-group=nagios



echo " configure of plugin completed " >> /tmp/nagios_plugin_install.log



#run make and make install



make ; make install



echo "installation of plugin complete" >> /tmp/nagios_plugin_install.log



# Nagios Plugin installation completed, now change the ownership



chown -R nagios:nagios /usr/local/nagios/



echo "ownership of folders changed " >> /tmp/nagios_plugin_install.log



##################################################################################################



echo "stage1 completed " /tmp/nagios_plugin_install.log



# Step 2 --> NRPE installation



#NRPE requires xinetd and libssl-dev so lets install it;

# On ubuntu/Debian machines

apt-get install xinetd

apt-get install libssl-dev



echo "xinted and libssl dev installed " >> /tmp/nagios_plugin_install.log



# On Fedora machines



#yum install xinetd ; yum install openssl-devel





# Download the nrpe

cd /root/nrpe

wget http://prdownloads.sourceforge.net/sourceforge/nagios/nrpe-2.13.tar.gz



echo "download of nrpe completed " >> /tmp/nagios_plugin_install.log

# untar

tar -xvzf nrpe-2.12.tar.gz



echo "untar of nrpe completed" >> /tmp/nagios_plugin_install.log

# change the location to nrpe base and configure and install the nrpe

cd nrpe-2.12

./configure

echo "configure of nrpe completed " /tmp/nagios_plugin_install.log

make all ; make install-plugin ; make install-daemon make install-daemon-config ; make install-xinetd ;

echo "make and install of nrpe completed " >> /tmp/nagios_plugin_install.log



# installation completed

#Now we need to configure the NRPE daemon so it will talk to our Nagios server, we'll do this buy editing /etc/xinetd.d/nrpe and adding our monitoring servers address



#Our Nagios servers internal address is 192.168.10.195



sed -i.bak 's/127.0.0.1/192.168.10.195/g' /etc/xinetd.d/nrpe



echo "edit of /etc/xinetd.d/nrpe completd >> /tmp/nagios_plugin_install.log



#Define the NRPE port in /etc/services file



#echo "nrpe            5666/tcp                        # NRPE"  | sudo tee -a /etc/services

echo "nrpe            5666/tcp                        # NRPE"  >> /etc/services



echo "edited the /etc/services file" >> /tmp/nagios_plugin_install.log



#Restart the xinetd service



/etc/init.d/xinetd restart



echo "xinetd service restarted " >> /tmp/nagios_plugin_install.log



# Lets confirm whether NRPE port is open or not



echo " Checking if NRPE port is open or not. The output of netstat command should contain line indicating 5666 port is Listening"

echo ""

netstat -tanpu | grep 5666



# Done

echo ""

echo "Done"

echo "Finish .." >>/tmp/nagios_plugin_install.log


#Nagios Download

#http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-3.4.1.tar.gz
