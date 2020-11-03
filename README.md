# Terraform minimalistic module for AWS Lightsail

From [campisano.org/Aws_terraform](http://www.campisano.org/wiki/en/Aws_terraform#Use_AWS_lightsail_simplified_service)

This project shows a minimalistic AWS Lightsail module configured with a custom vars.json variable to setup a cheap infrastrucutre in the AWS cloud.



Project Structure
-----------------

```
./
├── modules/lightsail           (lightsail files)
│   ├── input.ts                  (declare module input vars)
│   ├── main.ts                   (module source file for lightsail resources)
│   └── output.ts                 (declare module output vars)
│
├── init_script.sh              (make file used to simplify build process)
├── input.ts                    (declare main input vars)
├── main.ts                     (main source file to setup resources)
├── output.ts                   (declare main output vars)
├── provider.tf                 (aws provider configs)
├── terraform.tf                (terraform configs)
├── Makefile                    (make file used to setup useful commands)
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

* The AWS cli command. To install, see [the official doc](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) or do the following:

```
VERSION="2.0.61"
cd /tmp
curl -kLO "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${VERSION}.zip"
unzip "awscli-exe-linux-x86_64-${VERSION}.zip"
./aws/install -u -i ~/.local/aws -b "${HOME}"/bin
rm -rf aws "awscli-exe-linux-x86_64-${VERSION}.zip"
```

* Configure your credentials. See [the official doc](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html) or do the following:

```
# NOTE: for this example we will use "eu-west-1" region
aws --profile admin-user configure
# put the "Access key ID"
# put the "Secret access key"
# use "eu-west-1"
# use "json"
aws --profile admin-user iam list-users
```

* An SSH Key Pair. To create, do the following:

```
ssh-keygen -q -t rsa -b 2048 -N '' -f ~/.ssh/aws-keypair
chmod 400 ~/.ssh/aws-keypair
```

* The Terraform command. To install, see [the official doc](https://www.terraform.io/downloads.html) or do the followint:

```
VERSION="0.13.5"
cd /tmp
curl -kLO "https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_amd64.zip"
unzip "terraform_${VERSION}_linux_amd64.zip"
mv -f terraform ~/bin
rm -f "terraform_${VERSION}_linux_amd64.zip"
```

* (Optional) Install [Make](https://www.gnu.org/software/make/). This tool is used to run predefined terraform commands.



# Usage



Prepare
-------

Use `make init` command to prepare terraform local data and to download the AWS provider driver.

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



Customize
---------

It is possible to create several instance simply configuring the `vars.json` file. This is an example that creates an instance with an associated static IP and two instances without static IPs:

```
{
    "aws": {
        "region": "eu-west-1",
        "profile": "admin-user",
        "credentials_file": "~/.aws/credentials"
    },
    "lightsail": {
        "instance_public": {
            "zone": "eu-west-1a",
            "keypair_name": "aws-keypair",
            "blueprint_id": "debian_10",
            "bundle_id": "nano_2_0",
            "static_ip": true,
            "init_script": "init_script.sh"
        },
        "instance_private_a": {
            "zone": "eu-west-1a",
            "keypair_name": "aws-keypair",
            "blueprint_id": "debian_10",
            "bundle_id": "nano_2_0"
        },
        "instance_private_c": {
            "zone": "eu-west-1c",
            "keypair_name": "aws-keypair",
            "blueprint_id": "debian_10",
            "bundle_id": "nano_2_0"
        }
    }
}
```
