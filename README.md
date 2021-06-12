# Terraform minimalistic module for AWS Lightsail

From [campisano.org/Aws (Cloud)](http://www.campisano.org/wiki/en/Aws_(Cloud)#Use_AWS_lightsail_simplified_service)

This project shows how to use a minimalistic AWS Lightsail module (configurable with a custom vars.json file) to setup a cheap infrastrucutre in the AWS cloud.



Project Structure
-----------------

```
./
├── modules/lightsail           (lightsail module files)
│   ├── input.ts                  (declare module input vars)
│   ├── main.ts                   (module source file for lightsail resources)
│   └── output.ts                 (declare module output vars)
│
├── init_script.sh              (optional script to run at first boot)
├── input.ts                    (declare main input vars)
├── main.ts                     (main source file to setup resources)
├── output.ts                   (declare main output vars)
├── provider.tf                 (aws provider configs)
├── terraform.tf                (terraform configs)
├── Makefile                    (make file with a set of useful commands)
└── vars.json                   (json file to define custom variables)
```



Minimum System Requirements
---------------------------

* An AWS [account](https://portal.aws.amazon.com/gp/aws/developer/registration/index.html?client=lightsail).

* An AWS admin user with "Programmatic access" credential. To obtain, see [the official doc](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_create-admin-group.html) or do the following:

```
go to https://console.aws.amazon.com/iam/

  -> Groups -> Create New Group

    use "admin-group" name
    attach "AdministratorAccess" policy
    confirm "Create Group"

go back to https://console.aws.amazon.com/iam/

  -> Users -> Add user

    use "admin-user" name
    select "Programmatic access"
    select "admin-group"
    confirm "Create user"

NOTE: keep the "Access key ID" and the "Secret access key"
```

* Configure your credentials. See [the official doc](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html) or do the following:

```
export AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY_ID>
export AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_ACCESS_KEY>
export AWS_DEFAULT_REGION=<YOUR_REGION> # this example uses eu-west-1
```

* An SSH Key Pair. To create, do the following:

```
ssh-keygen -q -t rsa -b 2048 -N '' -f ~/.ssh/aws-keypair
chmod 400 ~/.ssh/aws-keypair
```

* Upload you public key in AWS Lightsail [Account Keys section](https://lightsail.aws.amazon.com/ls/webapp/account/keys), remember to upload in the same region used before.

* The Terraform command. To install, see [the official doc](https://www.terraform.io/downloads.html).

* Install [Make](https://www.gnu.org/software/make/). This tool is used to run predefined Terraform commands.



# Usage



Prepare
-------

Use `make init` command to prepare Terraform local data and to download the AWS provider driver.

Create
------

Use `make apply` to create the whole infrastructure.

Destroy
-------

Use `make destroy` to destroy the whole infrastructure.



Example
-------

* Output example for the `make apply` command:

![make apply image](/docs/README.md/make_apply.png?raw=true "make apply command")

* Output example for the `make destroy` command:

![make destroy image](/docs/README.md/make_destroy.png?raw=true "make destroy command")

* Login

You can login in your virtual machine with the command `ssh -i ~/.ssh/aws-keypair admin@111.22.33.44`. Remember to replace `111.22.33.44` with the static ip of your new machine. It is shown in the output of the `make apply` command.



Customize
---------

With this module it is possible to create several virtual machines. Each machine can be configured with or without a static ip resoure, and an initial script can be configured to customize the O.S. itself so that software can be added or removed programmatically. Such configuration can be done modifying the `vars.json` file.

The following code is a sample of a `vars.json` to:
* configure the aws provider;
* configure the lightsail module that creates:
  * a machine in the A zone with an initial script and an associated static IP;
  * a machine in the A zone without initial script or static IP;
  * a machine in the C zone without initial script or static IP.

```
{
    "aws_provider": {
        "region": "eu-west-1",
        "profile": "admin-user",
        "credentials_file": "~/.aws/credentials"
    },
    "lightsail_module": {
        "my_public_instance_name_1": {
            "zone": "eu-west-1a",
            "keypair_name": "aws-keypair",
            "blueprint_id": "debian_10",
            "bundle_id": "nano_2_0",
            "static_ip": true,
            "init_script": "init_script.sh",
            "public_ports_rules": "fromPort=22,toPort=22,protocol=tcp fromPort=80,toPort=80,protocol=tcp fromPort=8080,toPort=8080,protocol=tcp"
        },
        "my_private_instance_name_a": {
            "zone": "eu-west-1a",
            "keypair_name": "aws-keypair",
            "blueprint_id": "debian_10",
            "bundle_id": "nano_2_0"
        },
        "my_private_instance_name_c": {
            "zone": "eu-west-1c",
            "keypair_name": "aws-keypair",
            "blueprint_id": "debian_10",
            "bundle_id": "nano_2_0"
        }
    }
}
```
