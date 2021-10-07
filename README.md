# gitlab-runners
A repository to deploy gitlab runners in different cloud providers


## Digital Ocean

### Before running the script

We need to create an API token inside your Digital Ocean account.
[See docs](https://docs.digitalocean.com/reference/api/create-personal-access-token/)

Create a project and make it the default project inside DigitalOcean. I tried doing it 
with the [project module for ansible](https://docs.ansible.com/ansible/latest/collections/community/digitalocean/digital_ocean_project_module.html#ansible-collections-community-digitalocean-digital-ocean-project-module)
but it didn't work.

The token will be used in the ansible playbooks and should be stored encrypted in the variable `oauth_token`.

```bash
$ ansible-vault encrypt_string 'THE_DIGITAL_OCEAN_TOKEN' --vault-password-file .vault_pass.txt  --name oauth_token
oauth_token: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          35303632356533623334363134353963653133336538326632333963393932313634336262633237
          3432643762363336626532323164633335303939366232310a626164613733363964363764613532
          39373730343333616562623231643565383565363335343037356336653864663361393531343336
          3566373230306666340a336563306338386430663533393566616263623735363835326235306666
          39333466333533336137353264396364666564666132633130366436343262636333396563323331
          36393264646566666265383234313762396563376535376364313637336135323964366231336330
          30313762663532313262353966653634663464636432633761326235373237663565323333633334
          66353361396663346339
Encryption successful
```

### Keys

In order to create the runners, we need to upload the user SSH keys. The keys can be generated and later
encrypted with the scripts present in the `script/` folder.

### Create a project.yml file

If not provided, the Make tasks will use some sensible default values. However, you should provide a
project.yml file that describes what you need to create. 

This is a sample file:

```yaml

---
oauth_token: !vault |
  $ANSIBLE_VAULT;1.1;AES256
  39353939373665613732383739666432333739333066333665663238643136386233396431373366
  3532376435656161616532393234386633383331386336650a353863356531656639643439303539
  61383466616461383331356135393236626238353661323064663138386465346361313566313837
  3533323731343934330a336538663235656134626631303264376133656531666538353231323531
  31326664356464643933363731386637356662366463623365396533663138383432613138363734
  32643337333033613562653934616137626566383530386566303333643361336131633036343831
  65383466313861366636373663653437383161633435396234363031643232343533643230616565
  36376231643637396261

user_keys:
 user1:
   public_key: ../keys/user1_id_rsa.pub
   fingerprint: ../keys/user1_id_rsa_fingerprint
 user2:
   public_key: ../keys/user2_id_rsa.pub
   fingerprint: ../keys/user2_id_rsa_fingerprint
 user3:
   public_key: ../keys/user3_id_rsa.pub
   fingerprint: ../keys/user3_id_rsa_fingerprint
droplets:
  - name: droplet-for-user1
    size: s-2vcpu-2gb
    region: ams3
    image: ubuntu-20-04-x64
    user_key: user1
    tags: [gitlab, git, course]
  - name: droplet-for-user2
    size: s-2vcpu-2gb
    region: ams3
    image: ubuntu-20-04-x64
    user_key: user2
    tags: [gitlab, git, course]
  - name: droplet-for-user3
    size: s-2vcpu-2gb
    region: ams3
    image: ubuntu-20-04-x64
    user_key: user3
    tags: [gitlab, git, course]
```
### Install ansible

We use ansible to orchestrate the infrastructure. You need to install it.

Once installed, run:
```
$ make galaxy
```

to install the Ansible Galaxy dependencies.

### Creating the runners

Use the Make task:

```bash
$ make do_create_and_deploy
```

Relevant links:
- Availability zones: https://docs.digitalocean.com/products/platform/availability-matrix/
- [digital_ocean_sshkey_module](https://docs.ansible.com/ansible/latest/collections/community/digitalocean/digital_ocean_sshkey_module.html)
- [ansible digital ocean colletction](https://docs.ansible.com/ansible/latest/collections/community/digitalocean/index.html)
- [Digital Ocean API slugs](https://slugs.do-api.dev/)
