#!/bin/bash

k3d cluster create hw5-cluster  --api-port 6550  --servers 1  --agents 1  --port "8080:80@loadbalancer"

docker build -t go-app:local -f backend/Dockerfile backend
k3d image import go-app:local -c hw5-cluster

docker build -t html-app:local -f frontend/Dockerfile frontend
k3d image import html-app:local -c hw5-cluster

kubectl create namespace hw5-test-app

kubectl apply -n hw5-test-app -f k8s/postgres.yml
kubectl apply -n hw5-test-app -f k8s/backend.yml
kubectl apply -n hw5-test-app -f k8s/frontend.yml
kubectl apply -n hw5-test-app -f k8s/ingress.yml

# Note: update hosts file, if running on wsl2 for "127.0.0.1 localhw5.test"