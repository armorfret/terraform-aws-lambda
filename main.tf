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

resource "aws_lambda_permission" "allow_source" {
  function_name = "${aws_lambda_function.lambda.function_name}"
  statement_id  = "AllowExecutionFrom${title(var.source-types[count.index])}"
  action        = "lambda:InvokeFunction"
  principal     = "${var.source-types[count.index]}.amazonaws.com"
  source_arn    = "${var.source-arns[count.index]}"
  count         = "${length(var.source-arns)}"
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
