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


RUN mkdir /project
COPY ./hw_data_labeling.sh /project/hw_data_labeling.sh
RUN chmod +x /project/hw_data_labeling.sh
CMD ["sh", "-c", "./project/hw_data_labeling.sh; sleep 3600"]
