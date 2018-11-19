### HotelBraganca.club minecraft server configuration

This repository contains the terraform files that manage the infrastructure for the `hotelbraganca.club` minecraft server. Hop on by!

This manages and provisions a [MineOS](https://minecraft.codeemo.com/) instance running on Ubuntu 16.04, as well as importing the latest `hotelbraganca.club` server backup into the server listing. This is managed via [Terraform](https://terraform.io) and deployed on AWS, using an S3 backend for the terraform state.

# Getting started
1. Have `awscli` installed and configured, with your account credentials set up.
2. `terraform init`
3. `terraform apply`
4. Done. Ain't terraform great?

# Wait, this doesn't work for me!
You're free to use this as a starter if you want to manage your minecraft infrastructure on terraform! I'd wager you'd have to replace my stuff with yours, such as the ssh key, the domain, etc. I'm mostly putting these files up for personal convenience, but feel free to fork away and do your own!
