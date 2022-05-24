#!/bin/bash
# All except 88.201.141.255/32 will be dropped.
iptables -I DOCKER-USER 1 -i ens5 ! -s 88.201.141.255 -j DROP
