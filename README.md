# simple-gitlab-runner-terraform

Build a very simple "ready-to-use" EC2 instance for Gitlab-CI runner builds.

## Properties

 * Debian 9
 * Minimal AMI with Docker-CE for builds
 * Starts one runner for a given project

## Requirements

Create a IAM user with `AmazonEC2FullAcess` privilege.
Create a key pair and get its `pem` file.

## Build the AMI

```sh
packer build \
    -var 'access_key=ACCESS_KEY' \
    -var 'secret_key=SECRET_KEY' \
    -var 'region=eu-west-3' \
    packer.json
```

## Launch the instance

```sh
terraform init

terraform plan \
    -var 'access_key=ACCESS_KEY' \
    -var 'secret_key=SECRET_KEY' \
    -var 'region=eu-west-3' \
    -var 'key=KEY_PAIR_NAME' \
    -var 'pem_file=LOCAL_PEM_FILE_PATH' \
    -var 'simple-gitlab-runner-ami=GITLAB_RUNNER_AMI_ID' \
    -var 'gitlab_url=GITLAB_URL' \
    -var 'token=TOKEN' \
    -var 'project=PROJECT'

terraform apply \
    -var 'access_key=ACCESS_KEY' \
    -var 'secret_key=SECRET_KEY' \
    -var 'region=eu-west-3' \
    -var 'key=KEY_PAIR_NAME' \
    -var 'pem_file=LOCAL_PEM_FILE_PATH' \
    -var 'simple-gitlab-runner-ami=GITLAB_RUNNER_AMI_ID' \
    -var 'gitlab_url=GITLAB_URL' \
    -var 'token=TOKEN' \
    -var 'project=PROJECT'
```
