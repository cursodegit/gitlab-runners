for I in $(ls -I *.pub -I *_fingerprint keys/)
do
        echo "Decrypting ${I}"	
	ansible-vault decrypt --vault-password-file .vault_pass.txt keys/$I
done

