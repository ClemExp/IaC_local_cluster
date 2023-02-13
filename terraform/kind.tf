provider "kind" {
}

resource "kind_cluster" "default" {
  name = "new-cluster"
  wait_for_ready = true
  kind_config {
    kind = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"
      image = "kindest/node:v1.23.6@sha256:b1fa224cc6c7ff32455e0b1fd9cbfd3d3bc87ecaa8fcb06961ed1afb3db0f9ae"
      extra_port_mappings {
        
        container_port = 80
        host_port = 80
        protocol = "TCP"       
      }
      extra_port_mappings {
        container_port = 443
        host_port = 443
        protocol = "TCP"
      }
      kubeadm_config_patches = [
       "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n",
       "kind: ClusterConfiguration\napiServer:\n  extraArgs:\n    \"service-node-port-range\": \"80-32767\"\n" ]
    }

    node {
      role = "worker"
      image = "kindest/node:v1.23.6@sha256:b1fa224cc6c7ff32455e0b1fd9cbfd3d3bc87ecaa8fcb06961ed1afb3db0f9ae"
    }
  }
}
