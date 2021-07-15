resource "aws_s3_bucket" "source" {
  bucket = "codepipeline-packer-bucket-${random_id.default.hex}"
  acl    = "private"
  force_destroy = true

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "source" {
  bucket = aws_s3_bucket.source.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "archive_file" "init" {
  type        = "zip"
  source_file = "${path.module}/data/packer.json"
  output_path = "${path.module}/packer.zip"
}

resource "aws_s3_bucket_object" "source" {
  bucket = aws_s3_bucket.source.bucket
  key    = "packer.zip"
  source = "${path.module}/packer.zip"
  etag = data.archive_file.init.output_md5
}