#!/bin/bash

tr -d '\0' < /proc/device-tree/model >> ./edge-hw-monitor-labeling/hw_name
model_name=$(tr -d ' ' < /edge-hw-monitor-labeling/hw_name)

vendor_id=$(cat /TPU_device_ID |grep Vendor | egrep '1a6e|18d1' | awk -F ' ' '{print $2}' | awk -F '=' '{print $2}')
prod_id=$(cat /TPU_device_ID |grep ProdID | egrep '089a|9302' | awk -F ' ' '{print $3}' | awk -F '=' '{print $2}')


if [[ $model_name =~ "TX1" ]]; then
	kubectl label node $(cat node_name) gpu.model=Jetson-TX1 gpu.driver=$(cat /NVIDIA_driver_version | awk -F ',' '{print $2}' | awk -F ' ' '{print$2}') gpu.resource=tegrastats

elif [[ $model_name =~ "quill" ]]; then
	kubectl label node $(cat node_name) gpu.model=Jetson-TX2 gpu.driver=$(cat /NVIDIA_driver_version | awk -F ',' '{print $2}' | awk -F ' ' '{print$2}') gpu.resource=tegrastats

elif [[ $model_name =~ "Nano" ]]; then
	kubectl label node $(cat node_name) gpu.model=Jetson-Nano gpu.driver=$(cat /NVIDIA_driver_version | awk -F ',' '{print $2}' | awk -F ' ' '{print$2}') gpu.resource=tegrastats

elif [[ $model_name =~ "AGX" ]]; then
	kubectl label node $(cat node_name) gpu.model=Jetson-AGX gpu.driver=$(cat /NVIDIA_driver_version | awk -F ',' '{print $2}' | awk -F ' ' '{print$2}') gpu.resource=tegrastats

elif [[ ${vendor_id} == "1a6e" || ${vendor_id} == "18d1" ]] && [[ ${prod_id} == "089a" || ${prod_id} == "9302" ]]; then
	kubectl label node $(cat node_name) gpu.model=Google-Coral-TPU gpu.vendor.id=$vendor_id gpu.product.id=$prod_id

else
	echo "check agin"
fi
