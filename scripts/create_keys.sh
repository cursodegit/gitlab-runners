#!/bin/env bash
for I in $(seq 1 15); 
do 
	ssh-keygen -f keys/user${I}_id_rsa -b 4096 -N '' -C "Key for user $I"
	ssh-keygen -l -E md5 -f keys/user1_id_rsa | grep -Eo "MD5:[0-9a-zA-Z:]+\b" | sed -e 's/MD5://' > keys/user${I}_id_rsa_fingerprint
done
