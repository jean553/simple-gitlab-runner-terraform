# simple-gitlab-runner-terraform

Build a very simple "ready-to-use" EC2 instance for Gitlab-CI runner builds.

## Properties

 * Debian 9
 * Supports `docker` and `shell` builds (executors)
 * `awscli` installed for usage from gitlab-ci.yml file

NOTE: this project downloads and installs Python3.6 in order to get the latest version of `awscli`.
Python3.6 is not available on the last Debian stable version, no AMI of further version exist yet.

## Requirements

Create a IAM user with `AmazonEC2FullAcess` privilege.

If the runner is supposed to push built Docker images on a AWS ECR,
the IAM user must have the `AmazonEC2ContainerRegistryFullAccess`.

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
    -var 'project=PROJECT' \
    -var 'executor=EXECUTOR'

terraform apply \
    -var 'access_key=ACCESS_KEY' \
    -var 'secret_key=SECRET_KEY' \
    -var 'region=eu-west-3' \
    -var 'key=KEY_PAIR_NAME' \
    -var 'pem_file=LOCAL_PEM_FILE_PATH' \
    -var 'simple-gitlab-runner-ami=GITLAB_RUNNER_AMI_ID' \
    -var 'gitlab_url=GITLAB_URL' \
    -var 'token=TOKEN' \
    -var 'project=PROJECT' \
    -var 'executor=EXECUTOR'
```
