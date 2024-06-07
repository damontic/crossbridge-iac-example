resource "aws_ecs_cluster" "main" {
  name = "main"

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.main.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.main.name
      }
    }
  }
}

resource "aws_ecs_task_definition" "main" {
  family                   = "typeorm-express-typescript"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "typeorm-express-typescript",
    "image": "000000000000.dkr.ecr.us-east-1.localhost.localstack.cloud:4566/crossbridge/typeorm-express-typescript:0.0.1",
    "cpu": 1024,
    "memory": 2048,
    "essential": true
  }
]
TASK_DEFINITION
}

resource "aws_ecs_service" "typeorm" {
  name            = "typeorm-express-typescript"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 1
  #iam_role        = aws_iam_role.tg.arn
  #depends_on      = [aws_iam_role_policy.foo]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  network_configuration {
    subnets = [ aws_subnet.private.id ]
    #security_groups = [ ]
    assign_public_ip = true
  }

  #load_balancer {
  #  target_group_arn = aws_lb_target_group.tg.arn
  #  container_name   = "typeorm-express-typescript"
  #  container_port   = 8080
  #}

}
