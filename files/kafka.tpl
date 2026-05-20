#!/bin/bash
NODE_ID=${node_id}
sed -i "s/node.id=1/node.id=$NODE_ID/" /home/kafka/kafka/config/server.properties
sed -i "s/advertised.listeners=PLAINTEXT:\/\/localhost:9092/advertised.listeners=PLAINTEXT:\/\/kafka$NODE_ID.${domain_name}:9092/" /home/kafka/kafka/config/server.properties
sed -i "s/listeners=PLAINTEXT:\/\/localhost:9092,CONTROLLER:\/\/localhost:9093/listeners=PLAINTEXT:\/\/0.0.0.0:9092,CONTROLLER:\/\/0.0.0.0:9093/" /home/kafka/kafka/config/server.properties
sed -i "s/controller.quorum.voters=1@localhost:9093/controller.quorum.voters=1@kafka1.${domain_name}:9093,2@kafka2.${domain_name}:9093,3@kafka3.${domain_name}:9093/" /home/kafka/kafka/config/server.properties

CLUSTER_ID="YzM1NmY1MWNhY2U4NDFhY"
sudo -u kafka /home/kafka/kafka/bin/kafka-storage.sh format -t $CLUSTER_ID -c /home/kafka/kafka/config/server.properties

# Wait for DNS propagation to ensure quorum can be established
for i in 1 2 3; do
  while ! ping -c 1 kafka$i.${domain_name} &> /dev/null; do
    echo "Waiting for DNS resolution of kafka$i.${domain_name}..."
    sleep 5
  done
done

systemctl enable --now kafka.service