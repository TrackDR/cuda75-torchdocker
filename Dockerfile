# Start with CUDA base image
FROM trackdr/cudadocker75
MAINTAINER me

# Copy cudnn libraries into docker file
#COPY cuda/lib64/libcudnn.so /usr/local/cuda/lib64/libcudnn.so
#COPY cuda/lib64/libcudnn.so.7.0 /usr/local/cuda/lib64/libcudnn.so.7.0
#COPY cuda/lib64/libcudnn.so.7.0.64 /usr/local/cuda/lib64/libcudnn.so.7.0.64
#COPY cuda/include/cudnn.h /usr/local/cuda/include/cudnn.h
#COPY cuda_7.5.18_linux.run /cuda_7.5.18_linux.run

#WORKDIR /
#RUN ./cuda_7.5.18_linux.run -extract=`pwd`
#RUN ./cuda-samples-linux-*.run -noprompt
#RUN cd /usr/local/cuda/samples/1_Utilities/deviceQuery && make

# Install curl and dependencies for iTorch
RUN apt-get update && apt-get install -y \
  curl \
  ipython \
  python-zmq
# Run Torch7 installation scripts
RUN curl -sk https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash
RUN git clone https://github.com/torch/distro.git ~/torch --recursive
RUN cd ~/torch; ./install.sh
# Export paths
ENV PATH=/root/torch/install/bin:$PATH \
  LD_LIBRARY_PATH=$HOME/torch/install/lib:$LD_LIBRARY_PATH \
  DYLD_LIBRARY_PATH=$HOME/torch/install/lib:$DYLD_LIBRARY_PATH
# Set ~/torch as working directory
WORKDIR /root/torch
