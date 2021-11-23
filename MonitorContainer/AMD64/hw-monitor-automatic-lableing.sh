#!/bin/bash
nvidia-smi --query-gpu=driver_version,gpu_name --format=csv,noheader >> ./edge-hw-monitor-labeling/hw_name
kubectl label node $(cat node_name) gpu.driver=$(head -n 1 /edge-hw-monitor-labeling/hw_name | awk -F ',' '{print $1}') gpu.model=$(head -n 1 /edge-hw-monitor-labeling/hw_name | awk -F ' ' '{print $2$3}') gpu.resource=nvidia-smi
