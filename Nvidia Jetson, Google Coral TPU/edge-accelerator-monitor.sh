#!/bin/bash
if [ -f host_driver ];
then
	nvidia_jetson_result="jetson"
else
	vendor_id=$(cat /host_devices |grep Vendor | egrep '1a6e|18d1' | awk -F ' ' '{print $2}' | awk -F '=' '{print $2}')
	prod_id=$(cat /host_devices |grep ProdID | egrep '089a|9302' | awk -F ' ' '{print $3}' | awk -F '=' '{print $2}')
	
	coral_tpu_result=${vendor_id}-${prod_id}
fi

list=()
list+=(${nvidia_jetson_result}${coral_tpu_result})

case "$list" in
	"$nvidia_jetson_result")
		cat /proc/device-tree/model >> ./project/data.txt
		kubectl label node $(cat host_hostname) gpu.model=$(tr -d '\0' < /project/data.txt | tr -d ' ') gpu.driver=$(cat /host_driver | awk -F ',' '{print $2}' | awk -F ' ' '{print$2}') gpu.resource=tegrastats

	;;
	"$coral_tpu_result")
		kubectl label node $(cat host_hostname) gpu.model=${list}

	;;
esac
