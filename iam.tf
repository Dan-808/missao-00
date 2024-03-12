resource "aws_iam_policy" "s3_read_access" {

  name        = "S3ReadAccessPolicy"
  description = "Policy for reading S3 bucket contents"

  policy = jsonencode({ #formato que a aws usa para criar as politicas
    Version = "2012-10-17",
    Statement = [
      {
        Action = ["s3:*"],
        Effect = "Allow",
        Resource = [
          "arn:aws:s3:::${var.bucket}-${var.environment}",   #vai manipular esse bucket  
          "arn:aws:s3:::${var.bucket}-${var.environment}/*", # e o objeto dentro dele

        ],
      },
    ],
  })

}


resource "aws_iam_role" "ec2_s3_read_role" { #role que estou anexando no meu objeto

  name = "EC2S3ReadWriteRole"
  assume_role_policy = jsonencode({ #vai assumir a action pra ter o permissionamento
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Principal = { "Service" : "ec2.amazonaws.com" },
        Effect    = "Allow", #tem que ser com A maiusculo
        Sid       = "",
      },
    ],
  })

  depends_on = [aws_iam_policy.s3_read_access] # testar sem depends_on

}

resource "aws_iam_role_policy_attachment" "s3_read_access_attachment" { #criei dois componentes separados e agora estou juntando eles

  role       = aws_iam_role.ec2_s3_read_role.name
  policy_arn = aws_iam_policy.s3_read_access.arn
  depends_on = [aws_iam_role.ec2_s3_read_role]

}