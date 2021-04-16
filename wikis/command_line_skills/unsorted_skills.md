# Bucket of Skills

If you've looked through my repositories, you know that I have a hard time knowing how to organize my knowledge about cs stuff.  This file will be for anything command line until I get a sense of how it fits into the bigger picture.

## Networking?

### Use case: I have to access a windows fileshare local to a remote location, then selectively copy a collection of files to a local location both to share and to use for development purposes.

1. Find the fileshare
Suppose that IT has configured the namespace (which I don't understand) to take a convention in windows like `\\<prefix>-<instrument>-<barcode>.<location of fileshare>` with an example being `\\DEV-security_cam-07.myplace.local`.  Then you need to access it from a linux box.  You have to find the location on the network.  Hopefully the name of the instrument works, like `smb://security_cam-07`, but if not, try one of the following three:
```
ping dev-security_cam-07.myplace.local
telnet dev-security_cam-07.myplace.local
nslookup dev-security_cam-07.myplace.local
```
One of these should succeed in verifying that the name works, or should return information including an ip address.  If you get the ip address back (probably looks like `##.###.###.###`) you can access the location through a file explorer using smb, like `smb://<ip address>`.

1. Make the files accessible
To make the files accessible for scripts, etc, you will need to mount the fileshare:
- Create a mount location
```
cd \mnt
sudo mkdir windows
```
windows here is an arbitrary name I picked.
- Mount the fileshares to your designated location: `mount -t cifs -o username=<username>,password=<password> //<ip address>/<path> /mnt/windows`
Note, if you don't include the path to some directory, however short, on the fileshare, then the command above won't error or mount anything either.
1. Copy the files to the desired location
You can use `find` with regex to feed a list of files to a command to copy the desired data.  Here's a good example:
```
find /mnt/windows  -regex ".*/\(\(.+\.xml\)\|\(Error Log\.txt\)\)" -printf "%P\n" -type f -type d | tar czvf /home/nathaniel/Desktop/nanodrop.tar --no-recursion -C /mnt/windows -T -
```

### Moving files with wildcards

```
find ~/Desktop/test1 -name "2016*" -exec mv '{}' ~/Desktop/test2/ \;

find ~/Desktop/test1 -name "2015*" -exec mv '{}' . \;

find ~/Desktop/S7/Pictures/Camera -name "2016*" -exec mv '{}' . \;
```
