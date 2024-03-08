### Overview
This lab uses containerlab to spin up the hawkv6 test network containing XRd control-plane devices and docker [network-ninja container](https://github.com/INSRapperswil/network-ninja).

The lab was tested with the following things:
- XRd control-plane version 7.11.1.48I 
- containerlab 0.48.6
- Docker 24.0.7
- Docker Compose version v2.11.1


### Requirements
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
    ### download and install the latest release (may require sudo)
    bash -c "$(curl -sL https://get.containerlab.dev)"
    ```
4. Add the necessary option to sysctl and verify it:
   ```
   echo 'kernel.pid_max = 1048575' | sudo tee -a /etc/sysctl.conf
   echo 'fs.inotify.max_user_instances=64000' | sudo tee -a /etc/sysctl.conf
   sudo sysctl -p
   ```
5. Extract tarball:
   ```
   tar -xvzf xrd-control-plane-container-x86.7.11.1.48I.tgz
   ```
6. Load the XRd image into docker :
   ```
   docker load -i xrd-control-plane-container-x64.dockerv1.tgz-7.11.1.48I
   ```

### Deploy
Deploy the lab with the following command:
```
sudo containerlab deploy -t clab-hawkv6-network.yml
```

### Destroy
Destroy the lab with the following command:
```
sudo containerlab destroy -t clab-hawkv6-network.yml
```

### Connect to host
```
docker exec -it clab-hawkv6-HOST-A bash
docker exec -it clab-hawkv6-XR-1 /pkg/bin/xr_cli.sh
```

### Remote capture
Containerlab has excellent documentation about [using (remote) capture](https://containerlab.dev/manual/wireshark/).

You can either use the standard option:
```
ssh user@containerlab-host "sudo ip netns exec hawk9-XR-1 tcpdump -U -nni Gi0-0-0-0 -w -" | wireshark -k -i -
```
or read further about `clabshark`

#### clabshark 

To capture remote traffic, I wrote the following little bash function:
```
### start wireshark and listening on a containerlab device
function clabshark {
    if [ $### -ne 3 ]; then
      echo "Usage: clabshark <username@containerlab_address> <container_name> <interface_name>"
      return
    fi
    ssh $1 "sudo ip netns exec $2 tcpdump -U -nni $3 -w -" | wireshark -k -i -
}
```

I suggest adding it to the `.bashrc` file or including it into your own `.bash_functions` file and including this code in your `.bashrc`:
Don't forget to reload your `.bashrc` with the command `source .bashrc`.

```
### Load bash_functions when starting bash shell
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi
```
Don't forget to reload your `.bashrc` with the command `source .bashrc`.

After activating it, you can use it easily.
Here is an example of sniffing on XR-1 GigabitEthernet0/0/0/0:
```
clabshark user@clab-server clab-hawkv6-XR-1 Gi0-0-0-0
```
