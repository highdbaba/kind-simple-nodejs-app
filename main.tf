terraform {
  required_version = ">= 0.13"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
      #config_path = "~/.kube/config"
    }
  }
}

provider "kubectl" {
  config_path = "~/.kube/config"  # Path to your kubeconfig file
}

resource "kubectl_manifest" "example" {
  yaml_body = <<-EOT
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: nodejs-app
    spec:
      replicas: 3
      selector:
        matchLabels:
          name: nodejs-app
      template:
        metadata:
          labels:
            name: nodejs-app
        spec:
          containers:
          - name: nodejs-app-container
            image: 1759/simple-nodejs-app:latest
            ports:
            - containerPort: 3000
    EOT
}

resource "kubectl_manifest" "service" {
  yaml_body = <<-EOT
    apiVersion: v1
    kind: Service
    metadata:
      name: nodejs-app
    spec:
      selector:
        name: nodejs-app
      ports:
        - port: 3000
          nodePort: 30007
          targetPort: 3000
        
      type: NodePort
    EOT
}




