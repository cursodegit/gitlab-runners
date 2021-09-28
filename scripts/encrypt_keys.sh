for I in $(ls -I *.pub -I *_fingerprint keys/)
do 
	ansible-vault encrypt --vault-password-file .vault_pass.txt keys/$I
done
