resource "aws_s3_bucket" "mc-backups" {
  bucket = "hbc-mc-backups"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "prune"
    enabled = true

    noncurrent_version_expiration {
      days = 120
    }
  }

}

resource "aws_s3_bucket_policy" "mc-backup" {
  bucket = "${aws_s3_bucket.mc-backups.id}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "S3PolicyId1",
    "Statement": [
        {
            "Sid": "IPAllow",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "${aws_s3_bucket.mc-backups.arn}/*",
            "Condition": {
                "IpAddress": {
                    "aws:SourceIp": "${aws_instance.mc-server.public_ip}"
                }
            }
        }
    ]
}
POLICY
}
