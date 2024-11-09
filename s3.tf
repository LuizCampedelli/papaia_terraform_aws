resource "aws_s3_bucket" "example" {
  bucket = "papaia-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "papaia"
    Environment = "Dev"
  }
}
