# Virtualbox

## Resizing a hard drive

### Context
I've now had an experience where my virtual windows install complains about paging file size and local disk space to the point where I don't have enough memory to allocate to the paging file to meet recommendations let alone adress the local disk space.  It turns out you can't resize the local disk space through the 'Oracle VM Virtualbox Manager'

### How-to

1. First, shut down or pause the state of your VM
2. Then, ```cd``` into the directory where the .vdi file is located.  For me this is in the directory where I think of myself having installed the windows vm for Virtualbox
3. Then, submit the command to resize the hard drive.  For me this was like: ```me@mycomputer:~/Infrastructure/VirtualBox/W7$ VBoxManage modifyhd W7.vdi --resize 100000```
4. Now, fire up your VM.  Once logged in, start up a partition manager.
- If your VM OS is ubuntu, this would be something like gparted
5. For windows, I simply opened 'Computer Management' and selected disk management under storage in the left margin menu.  The partitions were listed here, and I simply right clicked on the hard drive partition and selected 'Extend Volume' and worked from there.
