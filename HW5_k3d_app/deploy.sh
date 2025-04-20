#!/bin/bash
k3d cluster create hw4-cluster  --api-port 6550  --servers 1  --agents 1  --port "8080:80@loadbalancer"

docker build -t check-k3d-app:local -f app/Dockerfile app
k3d image import check-k3d-app:local -c hw4-cluster

kubectl create namespace hw4-test-app
kubectl apply -f k8s/deployment.yml
kubectl apply -f k8s/service.yml
kubectl apply -f k8s/ingress.yml
