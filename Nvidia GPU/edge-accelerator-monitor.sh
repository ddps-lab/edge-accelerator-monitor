#!/bin/bash
nvidia-smi --query-gpu=driver_version,gpu_name --format=csv,noheader >> ./project/data.txt
kubectl label node $(cat host_hostname) gpu.model=$(head -n 1 /project/data.txt | awk -F ',' '{print $1}') gpu.driver=$(head -n 1 /project/data.txt | awk -F ' ' '{print $2$3}') gpu.resource=nvidia-smi
