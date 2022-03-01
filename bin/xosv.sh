#!/bin/bash -vx

pgrep -fax 'xosview \+cpus' || xosview +cpus &
pgrep -fax 'ssh work xosview \+cpus' || ssh work xosview +cpus &
pgrep -fax 'ssh imx6 \+cpus' || ssh imx6 xosview +cpus &
pgrep -fax 'ssh huanan \+cpus' || ssh huanan xosview +cpus &

#pgrep -fax 'ssh work acer \+cpus' || ssh acer xosview +cpus &
