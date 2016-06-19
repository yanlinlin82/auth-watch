#!/bin/bash

AUTH_LOG="/var/log/auth.log"

LIST_DIR="$(dirname $0)/ban-ip"
LIST_FILE="${LIST_DIR}/$(date +%Y-%m-%d-%H).txt"

[ -d ${LIST_DIR} ] || mkdir -pv ${LIST_DIR}

cat ${AUTH_LOG} \
	| grep -F 'authentication failure' \
	| grep -F 'rhost=' \
	| sed 's/^.*rhost=//' \
	| sed 's/\s.*$//' \
	| awk '$1!="" && s[$1]++==0' \
	| grep -v -f <(cat ${LIST_DIR}/*.txt 2>/dev/null) \
	>> ${LIST_FILE}

if [ "$(cat ${LIST_FILE} | wc -l)" == "0" ]; then
        rm -f ${LIST_FILE}
fi
