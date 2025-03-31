# --- DevOps Workspace Dockerfile for Coder ---

FROM ubuntu:22.04

# --- Base Setup ---
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  curl \
  wget \
  git \
  unzip \
  gnupg \
  lsb-release \
  software-properties-common \
  zsh \
  sudo \
  nano \
  vim \
  ca-certificates \
  net-tools \
  iputils-ping \
  dnsutils \
  openssh-client \
  bash-completion \
  tmux \
  python3-pip \
  jq && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# --- Install Terraform ---
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  tee /etc/apt/sources.list.d/hashicorp.list && \
  apt-get update && apt-get install -y terraform

# --- Install Nomad, Consul, Vault ---
RUN apt-get install -y nomad consul vault

# --- Install Ansible ---
RUN pip3 install ansible

# --- Install Nomad Pack CLI ---
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg && \
  echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list && \
  apt-get update && apt-get install -y nomad-pack

# --- Install LazyGit, fzf, ripgrep, bat ---
RUN add-apt-repository ppa:lazygit-team/release && apt-get update && apt-get install -y \
  lazygit \
  fzf \
  ripgrep \
  bat

# --- Add coder user ---
RUN useradd -m coder && echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER coder
WORKDIR /home/coder

CMD ["/bin/zsh"]

