locals {
  cilium_chart_version = "1.15.2"
  cilium_config = {
    kubeProxyReplacement = true
    gatewayAPI = {
      enabled = true
    }
    hubble = {
      relay = {
        enabled = true
      }
      ui = {
        enabled = true
      }
    }
  }
  cilium_chart_values = yamlencode(local.cilium_config)

  tmp_cilium_config_path = "${path.root}/tmp/cilium"
  cilium_install_script_path = "${path.module}/scripts/cilium.sh"
}
resource "null_resource" "cilium" {

  triggers = {
    base_path = local.tmp_cilium_config_path
    cilium_install_script_path = filesha256(local.cilium_install_script_path)
    cilium_chart_version = local.cilium_chart_version
    cilium_chart_values = local.cilium_chart_values
  }

  provisioner "local-exec" {
    command = "rm -rf ${local.tmp_cilium_config_path} && mkdir -p ${local.tmp_cilium_config_path}"
  }

  provisioner "local-exec" {
    command = "cat <<EOF > ${local.tmp_cilium_config_path}/cilium-chart-values.yaml\n${local.cilium_chart_values}\n"
  }

  provisioner "local-exec" {
    command = local.cilium_install_script_path
    environment = merge({
      BASE_PATH = self.triggers.base_path
      CILIUM_VERSION = self.triggers.cilium_chart_version
    })
  }
}
