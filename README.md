# yc-nextcloud-ha

This project contains code for creating high-availability nextcloud service in yandex cloud with `terraform` and `ansible`. `Patroni` postgreql is used as a HA database backend, `Redis` Sentinel Cluster used as a Session Handler and Cache, `Glusterfs` storage used for keeping user data between two `Nextcloud` application server, and `Nginx` reverse proxy used fo load-balancing and SSL termination with `LetsEncrypt` certificate. SSH access is available only through bastion server.

---

## Diagram

![web app scheme](/diagrams/yc-nextcloud-ha.png)

---

## Usage

copy example and set your private variables
```
cp terraform.tfvars.example terraform.tfvars
```
| Name                         | Description                                                                | Example                                  |
| ---------------------------- | -------------------------------------------------------------------------- | ---------------------------------------- |
| yc_token                     | https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token        | AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA  |
| yc_cloud_id                  | https://cloud.yandex.ru/docs/resource-manager/operations/cloud/switch-cloud| b1gg8sgd16g7qch5onqs                     |
| yc_folder_id                 | https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id     | b1gd129pp9ha0vnvf5g7                     |
| patroni_superuser_username   | patroni superuser name for login in postgresql database                    | root                                     |
| patroni_superuser_password   | patroni superuser password for login in postgresql database                | strongP@ssw0rd                           |
| patroni_replication_username | patroni replication username for replicate in postgresql database          | replication                              |
| patroni_replication_password | patroni replication password for replicate in postgresql database          | strongP@ssw0rd                           |
| nextcloud_admin_username     | your nextcloud admin user                                                  | admin                                    |
| nextcloud_admin_password     | your nextcloud admin password                                              | strongP@ssw0rd                           |

and set variables in `terraform.auto.tfvars`

| Name                | Description                                                     | Example            |
| ------------------- | --------------------------------------------------------------- | ------------------ |
| ssh_pub             | path to your ssh public ssh key                                 | ~/.ssh/id_rsa.pub  |
| ssh_key             | path to your ssh private ssh key                                | ~/.ssh/id_rsa      |
| yc_dns_zone_name    | dns zone (need create in yandex cloud before deploying project) | somikhailov-fun    |
| yc_zone             | default zone for project in yandex cloud                        | ru-central1-a      |
| yc_vpc_network_name | name new vpc-network for this project in yandex cloud           | nextcloud-network  |

get letsencrypt certificate (for example from this project [yc-nginx-certbot](https://github.com/somikhailov/yc-nginx-certbot) ) and copy to `ansile/roles/nginx/files` for deploying with ansible
```
./some/path ./ansible/roles/nginx/files
```

for running 
```bash
terraform init
terraform get
terraform plan
terraform apply -auto-approve
```

for running with remote backend stored in yandex cloud s3 bucket copy this `tf` file and set your private variables. 
```
cp backend.tf.example backend.tf
```

> for creating bucket you may uses this project [yc-s3-bucket](https://github.com/somikhailov/yc-s3-bucket)

for destroying
```bash
terraform destroy -auto-approve
```

---
## Installation

* terraform - [https://learn.hashicorp.com/tutorials/terraform/install-cli](https://learn.hashicorp.com/tutorials/terraform/install-cli).
* yandex.cloud provider - [https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs).
* yandex cli - [https://cloud.yandex.ru/docs/cli/operations/install-cli](https://cloud.yandex.ru/docs/cli/operations/install-cli).
* ansible - [https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## License
[MIT](https://choosealicense.com/licenses/mit/)