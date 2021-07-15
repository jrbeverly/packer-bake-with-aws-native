resource "aws_cloudwatch_log_group" "default" {
  name              = local.codebuild_loggroup_name
  retention_in_days = 180
  tags = {
    "org:xyz" = "Reason goes here"
  }
}

data "aws_iam_policy_document" "logs" {
  statement {
    sid       = "WriteToLogGroup"
    effect    = "Allow"
    resources = ["${aws_cloudwatch_log_group.default.arn}:*"]
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}
