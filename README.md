### Overview
This document shows how to run an XRd vRouter device with docker as the container runtime.
It can be used to create networks with XRd vRouter.
It was used to test the performance-measurement config between two XRd vRouters (xrd1 and xrd2).

This repo was heavily influced from the [XRd Tutorial](https://xrdocs.io/virtual-routing/tutorials/2022-08-22-xrd-images-where-can-one-get-them/).


The lab was tested with the following things:
- XRd vRouter version 7.11.1.48I 
- Docker 0.48.1
- Docker Compose version v2.3.3

Since the XRd vRouter is resource heavy, I used a Ubuntu 22.04 LTS server with 24 vCPUs and 64 GB RAM. It should be enough for +/- 10 XRd vRouters. More information can be found on [XRDocs](https://xrdocs.io/virtual-routing/tutorials/2022-08-22-setting-up-host-environment-to-run-xrd/)


### Requirements
The following things are needed to run the network:
- docker
- docker-compose

Follow these instructions to install the requirements. This requirements were created with regard to the `host-check` script from [xrd-tools](https://github.com/ios-xr/xrd-tools)
These steps were done on a Ubuntu 22.04 LTS system:
1. [Install and configure docker](https://docs.docker.com/engine/install/ubuntu/)
2. [Install docker-compose](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04).
3. Create a bash-alias for docker compose:
   ```
   echo "alias docker-compose='docker compose'" | tee -a ~/.bashrc
   source ~/.bashrc 
   ``` 
4. Add the necessary option to sysctl and verify it:
   ```
   echo 'kernel.pid_max = 1048575' | sudo tee -a /etc/sysctl.conf
   echo 'net.core.netdev_max_backlog=300000' | sudo tee -a /etc/sysctl.conf
   echo 'net.core.optmem_max=67108864' | sudo tee -a /etc/sysctl.conf
   echo 'net.core.rmem_default=67108864' | sudo tee -a /etc/sysctl.conf
   echo 'net.core.rmem_max=67108864' | sudo tee -a /etc/sysctl.conf
   echo 'net.core.wmem_default=67108864' | sudo tee -a /etc/sysctl.conf
   echo 'net.core.wmem_max=67108864' | sudo tee -a /etc/sysctl.conf
   echo 'net.ipv4.udp_mem=1124736 10000000 67108864' | sudo tee -a /etc/sysctl.conf
   echo 'fs.inotify.max_user_instances=64000' | sudo tee -a /etc/sysctl.conf
   echo 'net.bridge.bridge-nf-call-iptables=0' | sudo tee -a /etc/sysctl.conf
   echo 'net.bridge.bridge-nf-call-ip6tables=0' | sudo tee -a /etc/sysctl.conf
   sudo sysctl -p
   ```
5. Stop and disable AppArmor service ([more info](https://help.ubuntu.com/community/AppArmor)):
   ```
   sudo systemctl stop apparmor.service
   sudo systemctl disable apparmor.service
   sudo systemctl mask apparmor.service
   aa-teardown 
   ```
6. XRd needs at least 3x 1G hugepages per device and IOMMU has to be enabled. Since my server is an intel machine I persist the following settings:
   ```
   echo 'GRUB_CMDLINE_LINUX="intel_iommu=on iommu=pt default_hugepagesz=1G hugepagesz=1G hugepages=30 apparmor=0"' | sudo tee -a /etc/default/grub
   sudo update-grub
   ```
   More information about that topic can be found here:
   - https://xrdocs.io/virtual-routing/tutorials/2022-08-22-setting-up-host-environment-to-run-xrd/
   - https://www.intel.com/content/www/us/en/docs/programmable/683840/1-2-1/enabling-hugepages.html
   - https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/performance_tuning_guide/s-memory-transhuge
   - https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/5/html/tuning_and_optimizing_red_hat_enterprise_linux_for_oracle_9i_and_10g_databases/sect-oracle_9i_and_10g_tuning_guide-large_memory_optimization_big_pages_and_huge_pages-configuring_huge_pages_in_red_hat_enterprise_linux_4_or_5
7. Reboot your system so that the changes become active. `sudo reboot` 
8. Clone the `xrd-tools` repository:
    ```
    git clone https://github.com/ios-xr/xrd-tools.git ~/xrd-tools
    ```
9. Your system should be ready now to run XRd vRouters. Verify it with:
    ```
    sudo ~/xrd-tools/scripts/host-check
    ```
10. Load the XRd vRouter image into your docker registry and verify it:
    ```
    docker load -i xrd-vRouter-container-x64.dockerv1.tgz-7.11.1.48I
    docker images 
    ```

### Start container / lab
A XRd vRouter can be started with the following command:
```
 ~/xrd-tools/scripts/launch-xrd ios-xr/xrd-vRouter:7.11.1.48I --interfaces "pci:02:02.0;" -e config/xrd1.cfg --args "--env XR_vRouter_DP_HUGEPAGE_MB=4096 --name xrd1 -d"
```

Make sure you have the configuration file in the `config` folder and use the correct interface pci address.

#### Get the pci network info
To get the available pci interfaces use this command/example:
```
ins@master-sd:~$ sudo lshw -businfo -c network
Bus info          Device     Class      Description
===================================================
pci@0000:02:01.0  ens33      network    VMXNET3 Ethernet Controller
pci@0000:02:02.0  ens34      network    VMXNET3 Ethernet Controller
pci@0000:02:03.0  ens35      network    VMXNET3 Ethernet Controller
```

#### Get the management network info
To get the management address of the container use this command:
```
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container_name>
```

### Stop
Stop a container with:
```
docker stop xrd1
```

### Connect to host
```
docker exec -it xrd1 /pkg/bin/xr_cli.sh
```