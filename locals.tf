locals {
    aws_region = "us-east-1"
    project = "manual-task1"
    http_port = 80
    bastion_ami_id = "ami-07ad3ac74660c86c1"
    bastion_instance_type = "t3.micro"
    bastion_key_name  = "task1-key"
    llm_ami_id = local.bastion_ami_id
    llm_instance_type = "m6i.large"
}