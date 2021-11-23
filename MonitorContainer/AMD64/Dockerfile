FROM ubuntu:18.04


# install kubernetes
RUN apt-get update
RUN apt-get install -y apt-transport-https \
    wget \ 
    gnupg1 
RUN wget https://packages.cloud.google.com/apt/doc/apt-key.gpg 
RUN mv apt-key.gpg gpg
RUN apt-key add gpg
RUN echo deb http://apt.kubernetes.io/ kubernetes-xenial main > /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y kubelet=1.18.14-00 \
    kubeadm=1.18.14-00
RUN rm -rf gpg

RUN mkdir /edge-hw-monitor-labeling
COPY ./hw-monitor-automatic-lableing.sh /edge-hw-monitor-labeling/hw-monitor-automatic-lableing.sh
RUN chmod +x /edge-hw-monitor-labeling/hw-monitor-automatic-lableing.sh
CMD ["sh", "-c", "./edge-hw-monitor-labeling/hw-monitor-automatic-lableing.sh; sleep 3600"]
