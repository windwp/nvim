#!/bin/bash
if [[ ! -z "${@}" ]]; then
 ag -g "" | proximity-sort $@
else
 ag -g ""
fi
