resource "aws_security_group_rule" "kafka_egress_1" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kafka.id
  description       = "Allow all out"
}

resource "aws_security_group_rule" "kafka_ingress_1" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = aws_security_group.kafka.id
  description       = "Self"
}

resource "aws_security_group_rule" "kafka_ingress_2" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kafka.id
  description       = "SSH"
}

resource "aws_security_group_rule" "kafka_ui_egress_1" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kafka_ui.id
  description       = "Allow all out"
}

resource "aws_security_group_rule" "kafka_ui_ingress_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kafka_ui.id
  description       = "SSH"
}

resource "aws_security_group_rule" "kafka_ui_ingress_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kafka_ui.id
  description       = "Web UI"
}

resource "aws_security_group_rule" "kafka_ingress_from_ui" {
  type                     = "ingress"
  from_port                = 9092
  to_port                  = 9092
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.kafka_ui.id
  security_group_id        = aws_security_group.kafka.id
  description              = "Allow UI to connect to Kafka"
}
