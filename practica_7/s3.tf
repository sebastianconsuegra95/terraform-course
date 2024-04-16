resource "aws_s3_bucket" "cerverus_bucket" {
  bucket = local.s3-sufix
}
