# yc-tf-nextcloud

This project contains code for creating `docker` host in `yandex cloud` with `terraform` and deploy nextcloud with `ansible`. 

---

## Diagrams

![web app scheme](/diagrams/app.png)

---

## Usage

copy example and set your variables
```
cp terraform.tfvars.example terraform.tfvars
```

copy letsencrypt cert
```
./some/apth ./ansible/roles/nginx/files
```

for running 
```bash
terraform init
terraform plan
terraform apply -auto-approve
```

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