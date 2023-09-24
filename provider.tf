terraform {
    required_version = ">= 0.13"
  required_providers {
    kind = {
      source = "tehcyx/kind"
      version = "0.2.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "kind" {
  # Configuration options
}

resource "kind_cluster" "default2" {
  name = "test-cluster"
  node_image = "kindest/node:v1.23.4"
  wait_for_ready = true
  kind_config {
    kind = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"
    }

    node {
      role = "worker"
    }
  }
}

provider "kubectl" {
  host = "${kind_cluster.default.endpoint}"
  cluster_ca_certificate = "${kind_cluster.default.cluster_ca_certificate}"
  client_certificate = "${kind_cluster.default.client_certificate}"
  client_key = "${kind_cluster.default.client_key}"
}