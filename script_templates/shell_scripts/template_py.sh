#!/usr/bin/env bash

lcache=~/helloWorld/my/example_dir
source=/my/example/of/a/nasty/smb-share\:server\=server_name\,share\=someplace/with/nasty/adjective\ noun/coworkers\'s/directory

./myscript.py "$source" --out_dir $lcache > ~/helloWorld/myrepo/logs/script.log 2>&1
