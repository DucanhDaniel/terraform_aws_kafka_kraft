

output "kafka_ip_addresses" {
  value = formatlist("%v", aws_instance.kafka.*.public_ip)
}

output "kafka_ui_url" {
  value = "http://${aws_instance.kafka_ui.public_ip}:8080"
}
