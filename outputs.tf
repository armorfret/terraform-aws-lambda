output "arn" {
  value = "${aws_lambda_function.this.arn}"
}

output "invoke_arn" {
  value = "${aws_lambda_function.this.invoke_arn}"
}
