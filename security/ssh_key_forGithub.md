# Create a ssh key

To start substitute in your GitHub email address in the following (github recommendation):
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

Alternatively, ubuntu's recommendation is more simple:

```
ssh-keygen -t rsa -C "your_email@example.com"
```

When you're prompted to "Enter a file in which to save the key," press Enter. This accepts the default file location.

Alternatively, enter a file in which to save the key (/home/you/.ssh/id_rsa): \[Press enter\]

```
~/.ssh/id_rsa_arbitraryName
```

Enter the passphrase and confirm at the prompt

## Copy the ssh key to your clipboard:

If not installed yet:

```
sudo apt-get install xclip

xclip -sel clip < ~/.ssh/id_rsa_arbitraryName.pub
```

## Add your new ssh key to github:
1. In the upper-right corner of any page, click your profile photo, then click Settings.
2. In the user settings sidebar, click SSH and GPG keys.
3. Click New SSH key or Add SSH key.
4. In the "Title" field, add a descriptive label for the new key. For example, if you're using a personal Mac, you might call this key "Personal MacBook Air".
5. Paste your key into the "Key" field.
6. Click Add SSH key.
7. If prompted, confirm your GitHub password.

## If you want to have multiple keys:

Go to your ~/.ssh/config file and add
```
Host githubArbitraryName
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa_ArbitraryName
```

then be sure to save!

## Troubleshooting

If you have to type in the password for the key every time you use it, or you get an error like:

> Could not open a connection to your authentication agent

Then you may need to restart the ssh agent:
 
- Start the ssh agent in the background ```eval "$(ssh-agent -s)"```
- Add your ssh key to the ssh-agent ```ssh-add ~/.ssh/id_rsa_arbitraryName```

I like the explanation given [here](http://blog.joncairns.com/2013/12/understanding-ssh-agent-and-ssh-add/)

