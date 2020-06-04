variable "service-role-arn" {
  default = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "template_file" "ecs-task-execution-policy" {
  template = file("iam/policies/ecs-task-execution.json")

  vars = {
    region     = local.region
    account_id = data.aws_caller_identity.my.account_id
  }
}

resource "aws_iam_role" "ecs-task-execution" {
  name               = format("%s-ecsTaskExecution", local.product_name)
  assume_role_policy = file("iam/policies/ecs-task-assume-role.json")

  tags = {
    Name = format("%s-ecs-task-role", local.product_name)
  }
}

resource "aws_iam_role_policy" "ecs-task-execution" {
  name   = format("%s-ecs-task-policy", local.product_name)
  role   = aws_iam_role.ecs-task-execution.id
  policy = data.template_file.ecs-task-execution-policy.rendered
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution" {
  role       = aws_iam_role.ecs-task-execution.name
  policy_arn = var.service-role-arn
}
