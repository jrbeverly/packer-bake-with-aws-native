resource "aws_codebuild_project" "default" {
  name          = local.codebuild_name
  description   = "Defines an environment for generating AMIs with Packer."
  service_role  = aws_iam_role.codebuild.arn
  build_timeout = 30

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = var.compute_type
    image        = var.image
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "AWS_VPC_ID"
      value = var.vpc_id
    }

    environment_variable {
      name  = "AWS_SUBNET_ID"
      value = var.subnet_id[0]
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name = aws_cloudwatch_log_group.default.name
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = var.buildspec
  }

  vpc_config {
    vpc_id             = var.vpc_id
    subnets            = var.subnet_id
    security_group_ids = var.security_group_ids
  }
}

resource "aws_codepipeline" "pipeline" {
  name     = local.codepipeline_name
  role_arn = aws_iam_role.codepipeline.arn

  artifact_store {
    location = aws_s3_bucket.default.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Playbook"
      category         = "Source"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
      output_artifacts = ["playbook"]

      configuration = {
        S3Bucket             = var.source_bucket
        S3ObjectKey          = var.source_objectkey
        PollForSourceChanges = "true"
      }
    }
  }
  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["playbook"]
      output_artifacts = []
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.default.name
      }
    }
  }
}
