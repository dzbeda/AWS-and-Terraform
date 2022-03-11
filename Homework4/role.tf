resource "aws_iam_role" "ec2-role-s3-access" {
  name = "ec2-role-s3-access"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
      }
    ]
  }
EOF
}

resource "aws_iam_instance_profile" "ec2-role" {
  name = "ec2-role"
  role = aws_iam_role.ec2-role-s3-access.name
}

resource "aws_iam_role_policy" "s3-policy" {
  name = "ec2-role-s3-access-policy"
  role = aws_iam_role.ec2-role-s3-access.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "S3:*"
        ],
        "Resource": [
          "arn:aws:s3:::zbeda-state",
          "arn:aws:s3:::zbeda-state/*"
        ]
      },
      {
        "Effect":  "Allow",
        "Action": "s3:ListAllMyBuckets",
        "Resource": "arn:aws:s3:::*"
      }
    ]
  }
EOF
}