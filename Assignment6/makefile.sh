#!/bin/bash

sed -e "s/alias/${1}/g" -e "s/path/${2}/g" ${3}
#create_template demo bin unit.template