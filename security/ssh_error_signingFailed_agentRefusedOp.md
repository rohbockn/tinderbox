##Context

Today I couldn't remember my ssh key passwords on the git repository, so I went into github and removed the keys I had set for my two repositories, generated new keys, and tried to push.  I got errors:

```
sign_and_send_pubkey: signing failed: agent refused operation
Received disconnect from 192.30.253.112 port 22:11: Bye Bye
Connection to github.com closed by remote host.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

##Solution
It turns out the best explanation I found was [here](https://stackoverflow.com/a/22769324)

###Shut down the ssh agent
```
me@localhost:~/.ssh$ killall ssh-agent
me@localhost:~/.ssh$ killall gnome-keyring-daemon
```
###Starts the ssh agent again:

```eval "$(ssh-agent -s)"```

###Add keys, e.g.

```ssh-add ~/.ssh/id_theHardWay```

####Note, this is the private key, not the publick key with the .pub ending

###Confirm the key(s) you have added

```ssh-add -l```

####NOTE:
```ssh-add -D # removes keys you have added```

At this point you will still get the errors described.  Apparently this is because git or github or both will look for id_rsa by default.  You have to point git to use the correct keys for the correct repository

###Config:
Create the ~/.ssh/config file and create what I think as a sort of variable to map the correct key

```
Host githubTHW # This is arbitrary, i think of it as the variable name
  HostName github.com # THis must be what actually points to the correct url
  User git # This is important to use git
  IdentityFile ~/.ssh/id_theHardWay # This is the path to the key you want mapped
```

Note, I didn't use the # comments in my entry to the file. Now, configure git to use the entry in the config file you just made:

```
git remote set-url origin [config file var name]:[username]/[reponame (in github)]
```
e.g.
```
git remote set-url origin githubTHW:rohbockn/theHardWay
```

This finally worked!  However, you still have to type in your password each time to unlock the ssh key.  I believe this is because I killed the gnome-keyring-daemon... investigate and fix!

###The daemon

Turns out that simply starting the daemon again fixes the problem.
gnome-keyring-daemon --start
