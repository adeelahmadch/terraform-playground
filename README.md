##  terraform-playground
This repo contains the terraform configs to launch infrastrucutre in AWS Cloud. My setup looks like;

# How to Run this Repo


# Diagram

<img src="https://www.dropbox.com/s/vphxu15q9ajn2yc/devops-playground.jpg?dl=0" width="20%"/>


# Directory Structure

``
.
├── README.md
└── infrastructure
    └── dev
        ├── dev-alb.tf
        ├── dev-sg.tf
        ├── dev-vpc.tf
        ├── dev-web-servers.tf
        ├── output.tf
        ├── provider.tf
        ├── simple_html_app
        │   └── index.html
        ├── ssh-keypair.tf
        ├── ssh_keypair_files
        │   ├── devops-test
        │   └── devops-test.pub
        ├── terraform.tfstate
        ├── terraform.tfstate.backup
        └── variables.tf
``

# Variables
Many important values are controlled via variable, i tried to externalize and make config dynamic, however with next commits i will try to imporve that. for now i following values that are coming from varibles. 

``
1. region
2. profile
3. vpc and subnet network range
4. web server port and alb port
5. amazon linux ami image
6. ec2 instance type

``


# SSH-KeyPair:
This file `ssh-keypair.tf` create keypair in amazon account using your provided ssh keys that are in `ssh_keypair_files` folder. you can generate this using;

`ssh-keygen -t rsa`

Note: Normally you should not put your private key without passphrase and unencrypted. As i am using this setup for test so i will keep them as it is. 

# Provider
Terraform support different provider, I am using Amazon for my infrastructure. This terraform file `provider.tf` reads region and user profile from variables.tf.This assume you already have aws cli tool installed and you have configure aws cli tool with credentails profile: "devops-test". 

cat /home/myuser/.aws/credentials

``
[devops-test]
aws_access_key_id = AKIXXXXXXXXXXXXXXXX
aws_secret_access_key = VXXXXXXXXXXXXXXXXXXXX/PS4

``

cat /home/myuser/.aws/config

``
[default]
region = us-east-1

``

# Networking Setup with VPC

Terraform file `dev-vpc.tf` contains definations for networking setup. 

``
VPC: 172.16.0.0/16 (us-east-1)
Public Subnet 1: 172.16.248.0/22 (us-east-1a)
Public Subnet 2: 172.16.252.0/22 (us-east-1b)

``

Note: I used this cool site to calculate my subnet for my range; http://www.davidc.net/sites/default/subnets/subnets.html


# Security Group

This infrastructure setup , creates two security group i.e. one for your load balancer and one for your web server. You can see the definations in file `dev-sg.tf`. 

# Web Server
This infrastructure setup launch two ec2 an web server and use amazon linux as an base image. You can fine the defination in : `dev-web-servers.tf`.

To ssh into web server you can use following commands. 

`ssh -i path/devops-test ec2-user@IP-ADDRESS`

# Load Balancer

This infrastructure setup create one alb, that listen on port 80 and forward the traffic to your webserver using target group. you can find the definations in : `dev-alb.tf`. 






