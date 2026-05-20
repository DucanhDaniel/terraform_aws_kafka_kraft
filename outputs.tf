

output "kafka_ip_addresses" {
  value = formatlist("%v", aws_instance.kafka.*.public_ip)
}
