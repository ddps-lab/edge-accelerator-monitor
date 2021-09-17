# edge-accelerator-monitor

Accelerator-Aware Kubernetes Schedulerfor DNN Tasks on Edge Computing Environment

### Run Docker on Nvidia Jetson, Coral TPU on Rasberry pi 4 machine(use GPU)
```
sudo apt-get remove docker docker.io containerd runc nvidia-docker2
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get install containerd.io docker-ce docker-ce-cli
sudo docker pull kmubigdata/edge-accelerator-monitor
sudo docker run -it --privileged --name [docker container name] edge-accelerator-monitor /bin/bash
```

