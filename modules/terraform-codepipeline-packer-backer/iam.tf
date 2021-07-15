resource "aws_iam_role" "codebuild" {
  name               = local.codebuild_rolename
  description        = "Service-linked role used by Packer Bakery to enable Packer to spin up EC2 instances from CodeBuild."
  path               = local.base_role_path
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_policy.json

  tags = {
    "org:name" = "Xyz reason goes here"
  }
}

data "aws_iam_policy_document" "codebuild_assume_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}


resource "aws_iam_role" "codepipeline" {
  name               = local.codepipeline_rolename
  description        = "Service-linked role used by Packer Bakery to interact with AWS services."
  path               = local.base_role_path
  assume_role_policy = data.aws_iam_policy_document.codepipeline_assume_policy.json

  tags = {
    "org:name" = "Xyz reason goes here"
  }
}

data "aws_iam_policy_document" "codepipeline_assume_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}
