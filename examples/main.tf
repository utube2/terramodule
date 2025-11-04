

provider "aws" {
    region = "eu-north-1"
    profile = "terra"
}

data "aws_vpc" "default" {
    default = true
}

module "root_sg" {
  source = "git::https://github.com/utube2/terramodule.git"

  name        = "root-module"
  vpc_id      =  data.aws_vpc.default.id
  cidr_blocks = ["10.0.0.0/16"]
}


module "http_sg" {
  source = "git::https://github.com/utube2/terramodule.git//modules/http-80"

  name        = "submodule"
  vpc_id      = data.aws_vpc.default.id
  cidr_blocks = ["0.0.0.0/0"]
}

output "root_sg_id" {
    value = module.root_sg.security_group_id
}

output "http_sg_id" {
    value = module.http_sg.security_group_id
}