# Get the kafka AMI created by Packer
data "aws_ami" "kafka" {
  most_recent = true

  filter {
    name   = "name"
    values = ["kafka"]
  }

  owners = [var.aws_ami_account_id]
}

resource "aws_instance" "kafka_ui" {
  ami                     = data.aws_ami.kafka.id
  key_name                = aws_key_pair.pem-key.key_name
  subnet_id               = var.vpc_subnets[0]
  vpc_security_group_ids  = [aws_security_group.kafka_ui.id]
  disable_api_termination = false
  instance_type           = "t3.small"

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = "50"

    tags = {
      Name = "kafka-ui"
    }
  }

  tags = {
    Name = "kafka-ui"
  }

  user_data_replace_on_change = true
  user_data = templatefile("files/kafka-ui.tpl", {
    domain_name = var.domain_name
  })
}



# Create Kafka instance(s)
resource "aws_instance" "kafka" {
  ami                     = data.aws_ami.kafka.id
  key_name                = aws_key_pair.pem-key.key_name
  subnet_id               = var.vpc_subnets[count.index]
  vpc_security_group_ids  = [aws_security_group.kafka.id]
  disable_api_termination = false
  instance_type           = var.instance_type_kafka
  count                   = 3

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = "50"

    tags = {
      Name = "kafka ${count.index}"
    }
  }

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  tags = {
    Name = "kafka ${count.index}"
  }

  user_data_replace_on_change = true
  user_data = templatefile("files/kafka.tpl", {
    node_id     = count.index + 1
    domain_name = var.domain_name
  })

}

