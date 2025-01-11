#!/usr/bin/bash

head -n $1 $2 | sed 's/\*//g' > $3

