# Step-by-step guide

Note, ubuntu has a [high-level tutorial](https://tutorials.ubuntu.com/tutorial/tutorial-install-ubuntu-desktop?_ga=2.119631947.251959231.1502468949-2007631431.1502468949#0) with links to lower-level guides

1. Make a bootable usb drive for the install

Don't forget to use the Startup Disk Creator if using ubuntu

2. Be sure to encrypt the new ubuntu installation
3. Set up wireless:
- Request access to wireless. You may need to provide the MAC address.
- If needed, to obtain the MAC address, go to the network dropdown and select 'Connection Information.'  The MAC address is the 'Hardware Address'
4. Configure workspace:

Install compiz:  
```sudo apt-get install compizconfig-settings-manager```
Install compiz plugins:
```sudo apt-get install compiz-plugins```

5. Adjust trackpoint sensitivity if needed: (below from https://askubuntu.com/a/910785)

Identify the xinput

```xinput list```

Note the id number for the trackpoint (usually AlpsPS/2 ALPS DualPoint Stick).  List the properties for that id:

```xinput list-props <id#>```

Identify the desired setting to change (id in ())

Use ids to change settings:

```xinput set-float-prop <device id> <setting id> <setting>```

Note, you can use the strings listed for the devices, e.g.

```echo "xinput set-float-prop 'AlpsPS/2 ALPS DualPoint Stick' 'Device Accel Constant Deceleration' 15" >> ~/.xsessionrc```

Using the echo format above and outputting to xsessionrc should make the change persistent.

6. Obtain the CA certificate necessary to connect to WIFI
7. Install google chrome:

Most dependable way seems to be to use https://www.ubuntuupdates.org/ppa/google_chrome?dist=stable

8. Install a vpn tool

See Openvpn For Linux Users
Set up the openvpn repositories:
```wget -O - https://swupdate.openvpn.net/repos/repo-public.gpg|apt-key add -```

and an instance of:

```echo "deb http://build.openvpn.net/debian/openvpn/<version> <osrelease> main" > /etc/apt/sources.list.d/openvpn-aptrepo.list```

in my case:

```echo "deb http://build.openvpn.net/debian/openvpn/2.4 xenial main" > /etc/apt/sources.list.d/openvpn-aptrepo.list```

Install openvpn:

```apt-get update && apt-get install openvpn```


Follow remaining instructions in the page cited in a.)

If any issues arise, see https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos

9. Install git  
https://help.ubuntu.com/lts/serverguide/git.html
Install:

```sudo apt-get install git```

Configure https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup

Your identity:

```git config --global user.email "you@example.com"
git config --global user.name "Your name"```

Your editor:

```git config --global core.editor vi```

Check your settings

```git config --list```

Any global configuration you wish to make, such as types of files to ignore, should be stored in ~/.gitconfig (use ```--global``` option to git config).
If you want it to apply to other users, it needs to be in the /etc/gitconfig file (use ```--system``` option to git config)
For repository-specific configurations, use the .git/config subdirectory of that repository

10. Setup git for stash

Go to manage accounts, then SSH keys

[Create an ssh key](https://github.com/rohbockn/tinderbox/blob/master/security/ssh_key_forGithub.md)

or, alternatively follow the directions here:  https://confluence.atlassian.com/display/STASH0212/Creating+SSH+keys

11. Clone your first repository:

In stash, navigate to the repository of interest.  Within the repository, click the clone dropdown.  The clone dropdown provides a url looking string that starts with ssh:, we'll call it <pointer>.  Copy it.

Clone with:  ```git clone <pointer>```

Navigate into the cloned repository and connect the repository to the remote repostory with:

```git remote add origin <pointer>```

12. Install Java 8
```
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
```

accept the license
check the version with ```javac -version```
set env variables with ```sudo apt-get install oracle-java8-set-default```

13. Install R

This can all be done from existing repositories and the command line.  For the basic install, I start with ```sudo apt-get install r-base-core```.  This also brings in r-recommended, so it's a pretty good install just from this

14. Next install rJava from the command line.  

This typically errors from the R console.
Run, from the terminal  (sounds like this may all be made moot by e.)):

```
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export LD_LIBRARY_PATH=/usr/lib/jvm/java-8-oracle/jre/lib/amd64/server
R CMD javareconf -e
```

https://stackoverflow.com/a/25932872
Create the file /etc/ld.so.conf.d/java.conf with the following entries:

```
/usr/lib/jvm/java-8-oracle/jre/lib/amd64 /usr/lib/jvm/java-8-oracle/jre/lib/amd64/server
```

(Replace java-8-oracle with java-7-oracle or java-7-openjdk-amd64 depending on your java version)

Then:

```sudo ldconfig```

15. Now, from the rconsole, install RJDBC.

Search oracle jdbc in google, go log into the oracle site and download the driver, place in a location I'll call $loc$
Load authentication details (r script/terminal):

```
.jinit()
.jcall("java/lang/System","S","setProperty","oracle.net.tns_admin",<path to tnsnames directory>)
```

Create the jdbc driver (within each R session):
```drv <- JDBC("oracle.jdbc.OracleDriver", "$loc$/<jdbc driver filename>.jar")```
as the last step, run (from the terminal)
```R CMD javareconf -e```

16. Set up a remote desktop client
sudo apt-get install remmina (although this appears to come with ubuntu now?  It was already on my laptop)
Open the program, and click the icon for add a new connection
Under profile, add whatever you want for the name and group to describe the connection
On the 'Basic' tab, enter the server name (like, statistica-01)
enter the username of choice (like svc_statistica)
enter the password for the username of choice
enter the domain (e.g. MYGN)
Select your color depth

17. Go to the yWorks website and download yEd for linux
Move the shell file to the desired directory, e.g. ~/Infrastructure/yEd; cd into the directory
```chmod +x <shell file name>```

```./<shell file name>``` **DO NOT** sudo

18. If you need to transfer the windows VM from one the current host computer to a new host computer:
SSH into the current host computer:
e.g. ```ssh username@hostcomputer```
If you get an error that the connection is refused, you may have to install ```openssh-server``` on the current host

```sudo apt-get install openssh-server```

Once you successfully ssh, the terminal will request the password for the user on the host, ctrl+c out as all you need is for the ECDSA to be added to the list of known hosts
Copy over the image of the VM from the current host computer to the new host computer
e.g. ```scp -r username@hostcomputer:~/pathname/to/the/VM ~/pathname/to/the/newVM/home```
e.g. ```scp -r me@mycomputer:~/VirtualBox/W7 ~/Infrastructure/Virtualbox/```
This may take awhile to complete

18. install virtualbox

```sudo apt-get install virtualbox <virtualbox-ext-pack>```

<.*> might be optional, but I saw it recommended

Go to the menu bar, select machine, and add (or ctrl+A)
navigate to the image you copied over from the original host system
enter the subdirectories and select the *.vbox file (mine was W7.vbox)
click open
Configure network settings
Start virtualBox
Select settings from the top bar
Select network in the sidebar
Adapter 1/2 should be set to be
Attached to:  'Bridged Adapter'
Name: enp0s31f6
The other adapter not just set should be set to
Attached to:  'Bridged Adapter'
Name:  wlp2s0
Start the virtualBox windows VM and verify that the VM works on the new host machine
check that you can navigate to the network drives
internet works?
Remove the installation from the original machine to avoid license violations for MS
```sudo apt-get --purge autoremove virtualbox```
See https://askubuntu.com/a/151943 for details on why all the options above.

19. Find and connect printers
