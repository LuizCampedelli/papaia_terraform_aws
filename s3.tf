resource "aws_s3_bucket" "papaia" {
  bucket = "papaia-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "papaia"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "lb_logs" {
  bucket = "papaia-lb-logs-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "papaia-lb-logs"
    Environment = "Dev"
  }
}
