# Requirements
The following things are needed to run the network:
- docker
- docker-compose
- containerlab

Follow these instructions to install the requirements.
These steps were done on a Ubuntu 22.04 LTS system:
1. [Install and configure docker](https://docs.docker.com/engine/install/ubuntu/)
2. [Install docker-compose](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04)
3. Install containerlab:
    ```
    # download and install the latest release (may require sudo)
    bash -c "$(curl -sL https://get.containerlab.dev)"
    ```
4. Add the necessary option to sysctl and verify it:
   ```
   echo 'kernel.pid_max = 1048575' | sudo tee -a /etc/sysctl.conf
   echo 'fs.inotify.max_user_instances=64000' | sudo tee -a /etc/sysctl.conf
   sysctl -p
   ```
5. Load the XRd image into docker:
   ```
   docker load -i xrd-control-plane-container-x64.dockerv1.tgz-7.11.1.48I
   ```

# Deploy
Deploy the lab with the following command:
```
sudo containerlab deploy -t clab-test-performance-measurement-xrd.yml
```

# Destroy
Destroy the lab with the following command:
```
sudo containerlab destroy -t clab-test-performance-measurement-xrd.yml
```

# Connect to host
```
docker exec -it clab-test-performance-measurement-xrd-host-a bash
docker exec -it clab-test-performance-measurement-xrd-xrd1 /pkg/bin/xr_cli.sh
```