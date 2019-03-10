data "aws_iam_policy_document" "trust" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "lambda.amazonaws.com",
      ]
    }
  }
}

resource "aws_lambda_function" "this" {
  s3_bucket     = "${var.source_bucket}"
  s3_key        = "${var.source_prefix}${var.source_version}.zip"
  function_name = "${var.function_name}"
  role          = "${aws_iam_role.lambda.arn}"
  handler       = "${var.handler}"
  runtime       = "${var.runtime}"
  timeout       = "${var.timeout}"

  environment {
    variables = "${var.environment_variables}"
  }
}

resource "aws_lambda_permission" "allow_source" {
  function_name = "${aws_lambda_function.this.function_name}"
  statement_id  = "AllowExecutionFrom${title(var.source_types[count.index])}"
  action        = "lambda:InvokeFunction"
  principal     = "${var.source_types[count.index]}.amazonaws.com"
  source_arn    = "${var.source_arns[count.index]}"
  count         = "${length(var.source_types)}"
}

resource "aws_iam_role_policy" "lambda_perms" {
  name   = "lambda_perms"
  role   = "${aws_iam_role.lambda.name}"
  policy = "${var.access_policy_document}"
}

resource "aws_iam_role" "lambda" {
  name               = "${var.function_name}"
  assume_role_policy = "${data.aws_iam_policy_document.trust.json}"
}
