#!/bin/bash

helm repo add jenkinsci https://charts.jenkins.io
helm repo update

kubectl create ns jenkins

wget https://raw.githubusercontent.com/dmancloud/jenkins-kubernetes-kaniko/main/jenkins-sa.yaml
wget https://raw.githubusercontent.com/dmancloud/jenkins-kubernetes-kaniko/main/jenkins-volume.yaml
wget https://raw.githubusercontent.com/dmancloud/jenkins-kubernetes-kaniko/main/values.yaml

kubectl apply -f jenkins-sa.yaml
kubectl apply -f jenkins-volume.yaml

kubectl create secret docker-registry docker-credentials --docker-username=[userid] --docker-password=[Docker Hub access token] --docker-email=[user email address] --namespace jenkins

helm upgrade --install jenkins jenkinsci/jenkins -n jenkins --create-namespace -f values.yaml

