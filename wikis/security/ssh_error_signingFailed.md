## Context

You go to push changes and get an error like:
```
sign_and_send_pubkey: signing failed: agent refused operation
Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

quick solution:

```
killall ssh-agent; eval `ssh-agent`
ssh-add ~/.ssh/my_private_ssh_key
```
