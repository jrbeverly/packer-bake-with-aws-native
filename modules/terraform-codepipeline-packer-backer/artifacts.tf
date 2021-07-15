resource "aws_s3_bucket" "default" {
  bucket_prefix = local.bucket_name
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    "org:xyz" = "Sample reason"
  }
}

resource "aws_s3_bucket_public_access_block" "default" {
  bucket = aws_s3_bucket.default.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "artifacts" {
  statement {
    sid       = "S3ArtifactsDescribe"
    effect    = "Allow"
    resources = [aws_s3_bucket.default.arn]
    actions = [
      "s3:ListBucket",
      "s3:GetBucketPolicy",
      "s3:GetBucketVersioning",
      "s3:*",
    ]
  }

  statement {
    sid       = "S3ArtifactsReadWrite"
    effect    = "Allow"
    resources = ["${aws_s3_bucket.default.arn}/*"]
    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:*",
    ]
  }
}