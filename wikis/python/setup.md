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

## Anaconda

First, make sure that you have the latest version of conda installed:
```conda update -n root conda```

Then, run:
````conda update --all```
