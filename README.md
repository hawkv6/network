# HawkV6 Test Network

- [HawkV6 Test Network](#hawkv6-test-network)
  - [Overview](#overview)
  - [Deploy](#deploy)
  - [Destroy](#destroy)
  - [Connect to Host](#connect-to-host)
  - [Remote capture](#remote-capture)
  - [Additional Information](#additional-information)

## Overview

This lab uses Containerlab to spin up the HawkV6 test network containing XRd control-plane devices and Docker containers:
- [network-ninja container](https://github.com/INSRapperswil/network-ninja)
- [network-consul-ninja container](https://github.com/hawkv6/network-consul-ninja)

![HawkV6 Network Overview](images/hawkv6-network-overview.drawio.svg)


## Deploy
Deploy the lab with the following command:
```
sudo containerlab deploy -t clab-hawkv6-network.yml
```

## Destroy
Destroy the lab with the following command:
```
sudo containerlab destroy -t clab-hawkv6-network.yml
```

## Connect to Host
You can connect to the hosts using the following commands:
```
docker exec -it clab-hawkv6-HOST-A bash
docker exec -it clab-hawkv6-XR-1 /pkg/bin/xr_cli.sh
```

## Remote capture
Containerlab has excellent documentation about [using (remote) capture](https://containerlab.dev/manual/wireshark/).

You can either use the standard option:
```
ssh user@containerlab-host "sudo ip netns exec hawk9-XR-1 tcpdump -U -nni Gi0-0-0-0 -w -" | wireshark -k -i -
```

or read further about [clabshark](docu/clabshark.md)

## Additional Information
- More detailed information about the network can be found in [network documentation](docu/network.md)
- More detailed information about the installation and requirements can be found in [requirements](docu/requirements.md)

