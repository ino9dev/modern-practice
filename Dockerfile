#####
#
# CAUTION
# This dockerfile is not tested as clean instalation ever.
#
#####
FROM ubuntu:21.04
LABEL desc="This image is for modern unix command sandbox. This doesn't guide dockerfile best practice."
LABEL creator="ino9oni"

# timezone setting
RUN apt-get update && apt-get install -y tzdata
ENV TZ=Asia/Tokyo 
ENV LANG=en_US.UTF-8
# for cargo bin path
ENV PATH $PATH:/root/.
# for python pip bin path
ENV PATH $PATH:/root/.local/bin

USER root

# install basic commands
RUN apt-get update && apt-get install -y \
  bash \
  bat \
  cargo \
  exa \
  iputils-ping \
  tldr \
  locales \
  locales-all \
  npm \
  python3-pip \
  vim \
  wget

# install modern commands
RUN pip install --user glances
RUN pip install --user bottom
RUN cargo install procs
RUN cargo install gping
RUN npm install gtop -g
RUN mkdir /tmp/installer
WORKDIR  /tmp/installer

# for lsd installation
RUN wget https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd_0.20.1_amd64.deb
RUN dpkg -i lsd_0.20.1_amd64.deb
# for hyperfine installation
RUN wget https://github.com/sharkdp/hyperfine/releases/download/v1.11.0/hyperfine_1.11.0_amd64.deb
RUN dpkg -i hyperfine_1.11.0_amd64.deb

# move to homedir
WORKDIR /root

# invoke root process
CMD ["/bin/bash"]
