#!/bin/bash

set -euo pipefail

# Helm repos
helm repo add cilium https://helm.cilium.io/

helm repo update

# Install cilium
helm upgrade --install \
  cilium cilium/cilium \
  --version $CILIUM_VERSION \
  --values "$BASE_PATH"/cilium-chart-values.yaml \
  -n kube-system
