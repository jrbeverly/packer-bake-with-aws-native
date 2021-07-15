provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Environment = "Production"
      Owner       = "Ops"
    }
  }
}

resource "random_id" "default" {
  byte_length = 4
}

module "packer-bakery" {
  source = "./modules/terraform-codepipeline-packer-backer"

  key  = random_id.default.hex

  vpc_id             = module.vpc.vpc_id
  subnet_id          = module.vpc.private_subnets
  security_group_ids = [module.vpc.default_security_group_id]
  buildspec          = file("${path.module}/data/buildspec.yml")

  source_bucket    = aws_s3_bucket.source.bucket
  source_objectkey = "packer.zip"
}
