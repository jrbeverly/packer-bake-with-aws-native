# Packer Bakery with AWS Native

Creating pre-baked AMIs using Packer within AWS Native resources (Codepipeline / CodeBuild).

## Notes

- Tuning minimum permissions can be a bit difficult with the CodePipeline/CodeBuild error messages
- Artifacts bucket should store only temporary/cache files, and should be destroyable
- Logs from CodePipeline & CodeBuild can be restricted to a specific log group
- Unique 'key' identifier allow single-use of module within a common key-scope
- Events on-complete require additional resources/overhead
- Image is amazon pre-built, installing Packer on-the-fly

Although nice to leverage IAM solely for this, the benefits don't really outway the issues with leveraging CodePipeline for this kind of build. Splitting this CI/artifact process is less than ideal, but granting credentials to external providers that can spin up any EC2 & run arbitrary scripts has its concern points.
