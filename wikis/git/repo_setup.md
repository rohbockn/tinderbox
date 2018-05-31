# Setting Up a Repository

## Turn a Project Into a Local Repo with an Upstream Central Repo

1. First thing you want to do is initiate the repository locally, but don't make an initial commit yet:
```
git init
```
Next thing is to create the '.gitignore' file.  There may be files with sensitive information needed to run scripts on the local system that aren't needed or won't work on another system.  It may be a good idea to create templates for these that aren't ignored, but to ignore the working versions on the local system...

1. Create a .gitignore file at the level of your repo you want to govern.  Note, at the top level, all configuration apply to all subdirectories, however, if you create a .gitignore in a subdirectory, it should override any 'more global' settings.
1. Create any configurations.  Here are a few tips:
  - Reference: https://help.github.com/articles/ignoring-files/
  - '''*_debug.txt''' Ignore all files ending in _debug.txt
  - '''!my_debug.txt''' exception for my_debug.txt
  - '''**/node_modules''' ignore the node_modules directory or file no matter where it's found in the heirarchy and everywhere it is found
  - # marks a comment
  - Note, when a directory is excluded, I believe exceptions within will not work.  A possible exception may be if you exclude the directory using something like
  '''
  # make an exception for the directory
  !node_modules
  # ignore the contents of the directory
  node_modules/*
  # except for this file
  !node_modules/my_exception.txt
  '''
1. Look at the output from ```git status``` to see if files you wish to ignore are even listed as optional to add to the repository.  If not, then proceed to make the initial commit.
1. Make the initial commit:
```
git add --all
git commit -m "Initial Commit"
```
1. Now setup the central repository
  1. Log into bitbucket server and create a repository
  1. Locate the clone URL in the nav panel on the left (for example:  https://username@your.bitbucket.domain:7999/yourproject/repo.git).
  1. Push your files to the repository by running the following commands in the terminal (change the URL accordingly):
  ```
  git remote add origin https://username@your.bitbucket.domain:7999/yourproject/repo.git
  git push -u origin master
  ```
## Useful References

https://confluence.atlassian.com/bitbucketserver/importing-code-from-an-existing-project-776640909.html
