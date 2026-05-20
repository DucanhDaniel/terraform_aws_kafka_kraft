#!/bin/bash
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl enable --now docker

sudo docker run -d \
  -p 8080:8080 \
  --restart=always \
  -e DYNAMIC_CONFIG_ENABLED=true \
  -e KAFKA_CLUSTERS_0_NAME=AWS_KRaft_Cluster \
  -e KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS=kafka1.${domain_name}:9092,kafka2.${domain_name}:9092,kafka3.${domain_name}:9092 \
  provectuslabs/kafka-ui:latest
