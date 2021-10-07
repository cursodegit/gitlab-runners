galaxy:
	 ansible-galaxy install -r requirements.yml
do_create_and_deploy:
	 ansible-playbook --vault-password-file .vault_pass.txt digitalocean/create_and_deploy_droplets.yml
do_destroy:
	 ansible-playbook --vault-password-file .vault_pass.txt digitalocean/destroy_droplets.yml
