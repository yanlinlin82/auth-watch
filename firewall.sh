#!/bin/bash

LIST_DIR="$(dirname $0)/ban-ip"

iptables -F BAN-IP

IPV4_ADDR_PATTERN='[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*'
cat ${LIST_DIR}/*.txt | while read IP; do
	if !(echo ${IP} | grep -q "^${IPV4_ADDR_PATTERN}$"); then
		IP=$(host ${IP} | sed -r 's/^.*[^0-9]('${IPV4_ADDR_PATTERN}').*$/\1/')
	fi
	iptables -A BAN-IP -s ${IP} -j DROP
done
