resource "aws_lambda_function" "lambda" {
  s3_bucket     = "${var.lambda-bucket}"
  s3_key        = "lambdas/payload-${var.lambda-version}.zip"
  function_name = "${var.function-name}"
  role          = "${aws_iam_role.lambda.arn}"
  handler       = "${var.handler}"
  runtime       = "${var.runtime}"
  timeout       = "${var.timeout}"

  environment {
    variables = "${var.environment-variables}"
  }
}

resource "aws_iam_role_policy" "lambda_perms" {
  name   = "lambda_perms"
  role   = "${aws_iam_role.lambda.name}"
  policy = "${var.access-policy-document}"
}

resource "aws_iam_role" "lambda" {
  name               = "${var.function-name}"
  assume_role_policy = "${var.trust-policy-document}"
}
