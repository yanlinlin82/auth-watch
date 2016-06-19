#!/bin/bash

LIST_DIR="$(dirname $0)/ban-ip"

iptables -F BAN-IP

cat ${LIST_DIR}/*.txt | while read IP; do
	iptables -A BAN-IP -s ${IP} -j DROP
done
