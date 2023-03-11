#Make a vim main.tf file and inside it, write this config to launch ec2 instance using terraform
#Total 4 main.tf files are below with different use case, so use it accordingly

#1Creating single EC2 instance with Terraform (inside main.tf)

terraform {
        required_providers {
        aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"

}
}
required_version = ">= 1.2.0"
}

provider "aws" {
        region = "ap-south-1"
}

resource "aws_instance" "my_ec2_instance" {
        ami = "ami-0f8ca728008ff5af4"
        instance_type = "t2.micro"
        tags = {
               Name = "Terraform-P1-Instance"
}
}

output "ec2_public_ips" {
        value = aws_instance.my_ec2_instance.public_ip
}


#2Creating multiple instances by using COUNT (inside main.tf)


terraform {
        required_providers {
        aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"

}
}
required_version = ">= 1.2.0"
}

provider "aws" {
        region = "ap-south-1"
}

resource "aws_instance" "my_ec2_instance" {
        count = 5
        ami = "ami-0f8ca728008ff5af4"
        instance_type = "t2.micro"
        tags = {
               Name = "Terraform-P1-Instance"
}
}

output "ec2_public_ips" {
        value = aws_instance.my_ec2_instance[*].public_ip
}


#3Creating multiple instances with different names without using COUNT but using toset and for_each (inside main.tf)

terraform {
        required_providers {
        aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"

}
}
required_version = ">= 1.2.0"
}

provider "aws" {
        region = "ap-south-1"
}
locals {
        instances = toset(["Naruto","Goku","Luffy","Ichigo"])
}

resource "aws_instance" "my_ec2_test" {
        for_each = local.instances
        ami = "ami-0d81306eddc614a45"
        instance_type = "t2.micro"
        tags = {
                Name = each.key
}
}



#4Creating multiple instances with different "ami" for each different instance name. Like if one is using Amazon Linux ami then other one is Ubuntu ami

terraform {
        required_providers {
        aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"

}
}
required_version = ">= 1.2.0"
}

provider "aws" {
        region = "ap-south-1"
}
locals {
        instances = {"Naruto":"ami-0d81306eddc614a45","Goku":"ami-0f8ca728008ff5af4",,
"Luffy":"ami-0d81306eddc614a45","Ichigo":"ami-0f8ca728008ff5af4"}
}

resource "aws_instance" "my_ec2_test" {
        for_each = local.instances
        ami = each.value
        instance_type = "t2.micro"
        tags = {
                Name = each.key
}
}

