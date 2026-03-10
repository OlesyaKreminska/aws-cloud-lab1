data "archive_file" "get_all_authors_zip" {
  type        = "zip"
  source_file = "${path.module}/src/get-all-authors.js"
  output_path = "${path.module}/get-all-authors.zip"
}

resource "aws_lambda_function" "get_all_authors" {
  filename         = data.archive_file.get_all_authors_zip.output_path
  function_name    = "${var.namespace}-${var.stage}-get-all-authors"
  role             = aws_iam_role.get_all_authors.arn
  handler          = "get-all-authors.handler"
  source_code_hash = data.archive_file.get_all_authors_zip.output_base64sha256
  runtime          = "nodejs18.x"

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.authors.name
    }
  }
}
data "archive_file" "get_course_zip" {
  type        = "zip"
  source_file = "${path.module}/src/get-course.js"
  output_path = "${path.module}/get-course.zip"
}
resource "aws_lambda_function" "get_course" {
  filename         = data.archive_file.get_course_zip.output_path
  function_name    = "${var.namespace}-${var.stage}-get-course"
  role             = aws_iam_role.get_course.arn
  handler          = "get-course.handler"
  source_code_hash = data.archive_file.get_course_zip.output_base64sha256
  runtime          = "nodejs18.x"
  environment { variables = { TABLE_NAME = aws_dynamodb_table.courses.name } }
}

data "archive_file" "save_course_zip" {
  type        = "zip"
  source_file = "${path.module}/src/save-course.js"
  output_path = "${path.module}/save-course.zip"
}
resource "aws_lambda_function" "save_course" {
  filename         = data.archive_file.save_course_zip.output_path
  function_name    = "${var.namespace}-${var.stage}-save-course"
  role             = aws_iam_role.put_course.arn
  handler          = "save-course.handler"
  source_code_hash = data.archive_file.save_course_zip.output_base64sha256
  runtime          = "nodejs18.x"
  environment { variables = { TABLE_NAME = aws_dynamodb_table.courses.name } }
}

data "archive_file" "update_course_zip" {
  type        = "zip"
  source_file = "${path.module}/src/update-course.js"
  output_path = "${path.module}/update-course.zip"
}
resource "aws_lambda_function" "update_course" {
  filename         = data.archive_file.update_course_zip.output_path
  function_name    = "${var.namespace}-${var.stage}-update-course"
  role             = aws_iam_role.put_course.arn
  handler          = "update-course.handler"
  source_code_hash = data.archive_file.update_course_zip.output_base64sha256
  runtime          = "nodejs18.x"
  environment { variables = { TABLE_NAME = aws_dynamodb_table.courses.name } }
}

data "archive_file" "delete_course_zip" {
  type        = "zip"
  source_file = "${path.module}/src/delete-course.js"
  output_path = "${path.module}/delete-course.zip"
}
resource "aws_lambda_function" "delete_course" {
  filename         = data.archive_file.delete_course_zip.output_path
  function_name    = "${var.namespace}-${var.stage}-delete-course"
  role             = aws_iam_role.delete_course.arn
  handler          = "delete-course.handler"
  source_code_hash = data.archive_file.delete_course_zip.output_base64sha256
  runtime          = "nodejs18.x"
  environment { variables = { TABLE_NAME = aws_dynamodb_table.courses.name } }
}
data "archive_file" "get_all_courses_zip" {
  type        = "zip"
  source_file = "${path.module}/src/get-all-courses.js"
  output_path = "${path.module}/get-all-courses.zip"
}
resource "aws_lambda_function" "get_all_courses" {
  filename         = data.archive_file.get_all_courses_zip.output_path
  function_name    = "${var.namespace}-${var.stage}-get-all-courses"
  role             = aws_iam_role.get_all_courses.arn
  handler          = "get-all-courses.handler"
  source_code_hash = data.archive_file.get_all_courses_zip.output_base64sha256
  runtime          = "nodejs18.x"
  environment { variables = { TABLE_NAME = aws_dynamodb_table.courses.name } }
}