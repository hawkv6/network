# Requirements and Installation

## Requirements
The following are required to run the network:
- Docker
- Docker Compose
- Containerlab

### Versions 
The lab was tested with the following versions:
- XRd control-plane version 7.11.1
- Containerlab 0.48.6
- Docker 24.0.7
- Docker Compose v2.11.1

## Installation 
Follow these instructions to install the requirements on an Ubuntu 22.04 LTS system:

1. [Install and configure Docker](https://docs.docker.com/engine/install/ubuntu/).
2. [Install Docker Compose](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04).
3. Install Containerlab:
    ```bash
    ### Download and install the latest release (may require sudo)
    bash -c "$(curl -sL https://get.containerlab.dev)"
    ```
4. Add the necessary options to sysctl and verify:
    ```bash
    echo 'kernel.pid_max = 1048575' | sudo tee -a /etc/sysctl.conf
    echo 'fs.inotify.max_user_instances=64000' | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p
    ```
5. Extract the XRd control-plane tarball:
    ```bash
    tar -xvzf xrd-control-plane-container-x86.7.11.1.tgz
    ```
6. Load the XRd image into Docker:
    ```bash
    docker load -i xrd-control-plane-container-x64.dockerv1.tgz-7.11.1
    ```
