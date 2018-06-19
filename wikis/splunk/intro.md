# Splunk intro

## Install splunk locally

Especially if you are developing commands or custom visualizations, it is important to have a local splunk install.

1. Download:

Navigate here:
https://www.splunk.com/en_us/download/splunk-enterprise/thank-you-enterprise.html

Note, you will need to log on to your own account to take advantage of the free splunk trial.

Splunk provides a wget command ready made to download a tarball
wget -O splunk-7.1.0-2e75b3406c5b-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.1.0&product=splunk&filename=splunk-7.1.0-2e75b3406c5b-Linux-x86_64.tgz&wget=true'

Don't use the .deb file provided as it isn't possible as far as I know to install that without being the superuser.  Additionally, the tarball will allow you to install wherever you want

2. Extract:
tar xzvf splunk.tgz -C <path to where you want it installed>

3. Install/start up:

cd \<path to where you want it installed\>/splunk/bin

./splunk start --accept-license

./splunk enable boot-start -user splunk

./splunk start
./splunk stop
./splunk restart
./splunk help

4. On running '''./splunk start --accept-license''' a prompt will appear asking for you to set an admin password.  Once set, the install will complete and you will get a message such as

The Splunk web interface is at http://\<my computer name\>:8000

One easy way to know what your computer name is, is to open your terminal and note the prompt line:
me@<my computer name>: wd$
