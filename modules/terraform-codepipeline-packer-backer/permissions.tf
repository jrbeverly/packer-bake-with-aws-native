resource "aws_iam_role_policy" "codebuild_logs" {
  name   = "CloudwatchLogsWriteOnly"
  role   = aws_iam_role.codebuild.name
  policy = data.aws_iam_policy_document.logs.json
}

resource "aws_iam_role_policy" "codepipeline_logs" {
  name   = "CloudwatchLogsWriteOnly"
  role   = aws_iam_role.codepipeline.name
  policy = data.aws_iam_policy_document.logs.json
}

resource "aws_iam_role_policy" "codebuild_artifacts" {
  name   = "ArtifactsReadWrite"
  role   = aws_iam_role.codebuild.name
  policy = data.aws_iam_policy_document.artifacts.json
}

resource "aws_iam_role_policy" "codepipeline_artifacts" {
  name   = "ArtifactsReadWrite"
  role   = aws_iam_role.codepipeline.name
  policy = data.aws_iam_policy_document.artifacts.json
}

resource "aws_iam_role_policy" "sources" {
  name   = "SourceRead"
  role   = aws_iam_role.codepipeline.id
  policy = data.aws_iam_policy_document.source.json
}

resource "aws_iam_role_policy" "codebuild" {
  name   = "BakeryInvocation"
  role   = aws_iam_role.codebuild.id
  policy = data.aws_iam_policy_document.codebuild.json
}

data "aws_iam_policy_document" "codebuild" {
  statement {
    sid    = "CodeBuildBasePolicy"
    effect = "Allow"
    actions = [
      "ec2:CreateNetworkInterfacePermission",
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs",
    ]
    resources = ["*"]
  }

  statement {
    sid    = "EC2CreateAction"
    effect = "Allow"
    actions = [

      "ec2:AttachVolume",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CopyImage",
      "ec2:CreateImage",
      "ec2:CreateKeypair",
      "ec2:CreateSecurityGroup",
      "ec2:CreateSnapshot",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:DeleteKeyPair",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteSnapshot",
      "ec2:DeleteVolume",
      "ec2:DeregisterImage",
      "ec2:DescribeImageAttribute",
      "ec2:DescribeImages",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeRegions",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeSnapshots",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DetachVolume",
      "ec2:GetPasswordData",
      "ec2:ModifyImageAttribute",
      "ec2:ModifyInstanceAttribute",
      "ec2:ModifySnapshotAttribute",
      "ec2:RegisterImage",
      "ec2:RunInstances",
      "ec2:StopInstances",
      "ec2:TerminateInstances",
      "ec2:DeleteNetworkInterface"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "codepipeline" {
  name   = "CodePipelinePolicy"
  role   = aws_iam_role.codepipeline.id
  policy = data.aws_iam_policy_document.codepipeline.json
}

data "aws_iam_policy_document" "codepipeline" {
  statement {
    sid    = "CodeBuildPolicy"
    effect = "Allow"
    actions = [
      "codebuild:ListBuildsForProject",
      "codebuild:BatchGetBuilds",
      "codebuild:BatchGetProjects",
      "codebuild:StartBuild",
      "codebuild:StopBuild",
    ]
    resources = [aws_codebuild_project.default.id]
  }
}


data "aws_iam_policy_document" "source" {
  statement {
    sid       = "S3SourceDescribe"
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.source_bucket}"]
    actions = [
      "s3:ListBucket",
      "s3:GetBucketPolicy",
      "s3:GetBucketVersioning",
      "s3:*",
    ]
  }

  statement {
    sid       = "S3SourceReadWrite"
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.source_bucket}/*"]
    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:*",
    ]
  }
}
