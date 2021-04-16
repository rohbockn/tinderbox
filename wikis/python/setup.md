# How to setup python for my use cases

## Preferred method:

```
sudo apt install python3-venv
python3 -m venv .venv
ls -a
source .venv/bin/activate
deactivate
echo $PATH # just note the default path
source .venv/bin/activate
echo $PATH # note the change
vi .gitignore # be sure to ignore the .venv directory
pip install pandas # yes, it's this easy
pip install ipython # ipython is more friendly in interactive mode than just python
pip install pylint # A linter.  Other options include flake8, or pylint, black, or other
pylint myscript.py # note black will make suggested changes, flake8 and pylint suggest the changes
git diff myscript.py
```

Note, for python2, use

```
sudo apt-get install python-virtualenv
python -m virtualenv .venv

```

otherwise, it works the same.

Some other useful tips for setup:
- Note that each time you start a virtual environment, you are starting fresh and will need to install anything you need for the session.  So, make any necessary installations for your activities, then run ```pip freeze > arbitrary.txt``` to create a list of versioned packages you are using.  Then you can quickly recreate your environment (or someone elses) by running ```pip install -r arbitrary.txt``` 

## Anaconda

First, make sure that you have the latest version of conda installed:
```conda update -n root conda```

Then, run:
````conda update --all```
