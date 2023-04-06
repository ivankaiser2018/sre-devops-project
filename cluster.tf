data "aws_subnet" "subnet-one-ecs" {
  
  filter  {
    name   = "tag:Name"
    values = ["subnet-one"]
    
  }

}

# Definição da tarefa do Metabase
resource "aws_ecs_task_definition" "metabase" {
  family                   = "metabase"
  container_definitions    = jsonencode([{
    name      = "metabase"
    image     = "metabase/metabase:latest"
    cpu       = 512
    memory    = 1024
    essential = true
    portMappings = [
      {
        containerPort = 3000,
        hostPort      = 3000
      }
    ]
  }])
}


resource "aws_ecs_cluster" "ecs_cluster" {
    name  = "cluster-metabase"
}

# Criação do serviço do Metabase
resource "aws_ecs_service" "metabase" {
  name            = "metabase"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.metabase.arn
  desired_count   = 1
  launch_type     = "EC2"

#   network_configuration {
   #  subnets          = data.aws_subnets.subnet-one-ecs.id[0]
  #   security_groups  = [aws_security_group.metabase.id]
  #   assign_public_ip = false
  # }
}


# Criação das instâncias EC2
resource "aws_instance" "metabase" {
  ami           = "ami-06e46074ae430fba6"
  instance_type = "t2.micro"
  key_name      = "key2023"
  vpc_security_group_ids = [aws_security_group.metabase.id]
  subnet_id     = data.aws_subnet.subnet-one-ecs.id
}



# Regras de segurança para o Metabase
resource "aws_security_group" "metabase" {
  name_prefix = "metabase"
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}