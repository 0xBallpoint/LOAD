####### IAM POLICY #######

resource "aws_iam_role" "instancerole" {
  name = "InstanceRole"
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "ec2.amazonaws.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "serverinstancerole"
  role = aws_iam_role.instancerole.name
}
