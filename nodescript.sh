#!/bin/bash

# Set the name of your Kind cluster (change this as needed)
CLUSTER_NAME="idowu-kind-cluster"

# Check if Kind is installed
if ! command -v kind &> /dev/null; then
  echo "Kind is not installed. Please install Kind first: https://kind.sigs.k8s.io/docs/user/quick-start/"
  exit 1
fi

# Create a Kind cluster
kind create cluster --name "$CLUSTER_NAME"

# Set the current context to the Kind cluster
kubectl config use-context "$CLUSTER_NAME"

# Verify cluster status
kubectl cluster-info

echo "Kind cluster '$CLUSTER_NAME' is now deployed and set as the current context."