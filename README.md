# simple-gitlab-runner-terraform

Build a very simple "ready-to-use" EC2 instance for Gitlab-CI runner builds.

## Properties

 * Debian 9
 * Minimal AMI with Docker-CE for builds
 * EC2 script to start Gitlab-CI runner

## IAM user

Create a IAM user with `AmazonEC2FullAcess` privilege.

## Build the AMI

```sh
packer build \
    -var 'access_key=ACCESS_KEY' \
    -var 'secret_key=SECRET_KEY' \
    -var 'region=eu-west-3' \
    packer.json
```
