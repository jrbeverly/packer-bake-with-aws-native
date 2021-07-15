locals {
  base_name      = "bakery"
  base_role_path = "/packer-bakery/"
}

locals {
  bucket_name             = "${local.base_name}-${var.key}-artifacts"
  codebuild_rolename      = "${local.base_name}-${var.key}-codebuild"
  codepipeline_rolename   = "${local.base_name}-${var.key}-codepipeline"
  codebuild_name          = "${local.base_name}-${var.key}-codebuild"
  codepipeline_name       = "${local.base_name}-${var.key}-codepipeline"
  codebuild_loggroup_name = "/aws/codebuild/${local.base_name}-${var.key}"
}