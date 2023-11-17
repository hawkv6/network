### Overview
This lab uses containerlab to run 3 XRd control-plane devices and two docker [network-ninja container](https://github.com/INSRapperswil/network-ninja). It was used to test performance-measurement config on XRd control-plane nodes.

The lab was tested with the following things:
- XRd control-plane version 7.11.1.48I 
- containerlab 0.48.1
- Docker 0.48.1
- Docker Compose version v2.3.3


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
   sysctl -p
   ```
5. Load the XRd image into docker:
   ```
   docker load -i xrd-control-plane-container-x64.dockerv1.tgz-7.11.1.48I
   ```

### Deploy
Deploy the lab with the following command:
```
sudo containerlab deploy -t clab-test-performance-measurement-xrd.yml
```

### Destroy
Destroy the lab with the following command:
```
sudo containerlab destroy -t clab-test-performance-measurement-xrd.yml
```

### Connect to host
```
docker exec -it clab-test-performance-measurement-xrd-host-a bash
docker exec -it clab-test-performance-measurement-xrd-xrd1 /pkg/bin/xr_cli.sh
```

### Remote capture
Containerlab has excellent documentation about [using remote capture](https://containerlab.dev/manual/wireshark/).

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
Here is an example of sniffing on xrd1 GigabitEthernet0/0/0/0:
```
ssh user@containerlab-host "sudo ip netns exec clab-test-performance-measurement-xrd-xrd1 tcpdump -U -nni Gi0-0-0-0 -w -" | wireshark -k -i -
```