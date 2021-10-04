#!/bin/env bash
for I in $(seq 1 15); 
do 
	ssh-keygen -f keys/user${I}_id_rsa -b 4096 -N '' -C "Key for user $I"
	ssh-keygen -l -E md5 -f keys/user${I}_id_rsa.pub | grep -Eo "MD5:[0-9a-zA-Z:]+\b" | sed -e 's/MD5://' > keys/user${I}_id_rsa_fingerprint
	puttygen keys/user${I}_id_rsa -O private -o keys/user${I}_id_rsa.ppk
done
