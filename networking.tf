module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "AccountVPC"
  cidr = "10.0.0.0/16"

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  default_security_group_name = "DefaultSG"

  azs             = ["us-east-1a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
