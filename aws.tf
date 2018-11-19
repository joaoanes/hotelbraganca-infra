provider "aws" {
  region                  = "eu-central-1"
}

resource "aws_key_pair" "rsa" {
  key_name = "all/ssh-keys/rsa"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDxdgNAuxICZL7slgmfFIJshdwSqYcHLXdduKOHF8kinR4Es2gtd2ws09XzfHFCydpfFF//BgXNMMPlTQGap8OZD9f0fO8uViP/dAfFuASGqDFQLfrQ9rLxbNYMbdnl0SAfgICrQY0K76CUriS/3YxAZVYVWIatIAc2j11f0hfn9RvRkR/kisLhdl67gEdnMovCGD4V8+tblfg7XbEvv+aKFVmarpfIYypmrtqBCFzLzCv53D4SIJyBFXj5oDkzHfCvD3V2a2qdxlHd7nF6gSY5q0u/6+g4UclSIp68ndj6Ao9yGbXZ38HPStoZpx/vwqKfUmq3fGadGHM2cky1M73p"
}
