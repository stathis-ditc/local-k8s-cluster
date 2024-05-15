#resource kubernetes_namespace_v1 "tigera-operator" {
#  metadata {
#    name = "tigera-operator"
#  }
#}
#
#resource "helm_release" "calico" {
#  chart = "tigera-operator"
#  name  = "tigera-operator"
#  namespace = kubernetes_namespace_v1.tigera-operator.id
#
#  repository = "https://docs.tigera.io/calico/charts"
#  version = "v3.26.0"
#}

#resource "helm_release" "cilium" {
#  chart = "cilium/cilium"
#  name  = "cilium"
#  namespace = "kube-system"
#  version = "1.13.3"
#
#  repository = "https://helm.cilium.io/"
#  values = [
#    file("helm/cilium/values.yaml")
#  ]
#}