# Network Documentation

## L3 Information
The network configuration is detailed in the diagram below, showing IP addresses and interfaces.

![L3 Network Diagram](images/hawkv6-network-l3.drawio.svg)

## Topology Information
The physical connections and interfaces of the network are illustrated in the topology diagram below.

![L2 Network Diagram](images/hawkv6-network-l2.drawio.svg)

## Additional Information

### Full SIDs Usage
- The network uses full SIDs because the [hawkwing](https://github.com/hawkv6/hawkwing) and [hawkeye](https://github.com/hawkv6/hawkeye) applications do not support compressed SIDs.

### SRv6 SID Structure
- The SRv6 SIDs are structured as `fc00:0:X:Y:1::`, where `X` is the Node ID and `Y` is the Algorithm ID.
  - **Without Flexible Algorithm**: 
    - XR-1: `fc00:0:1:0:1::`
    - SITE-C: `fc00:0:c:0:1::`
  - **With Flex Algo 128**:
    - XR-1: `fc00:0:1:128:1::`
    - SITE-C: `fc00:0:c:128:1::`

### SR-Aware Firewalls
- **SERA-1**: `fc00:0:2f::/64` (Connected to XR-2)
- **SERA-2**: `fc00:0:3f::/64` (Connected to XR-3)

### Snort Instances
- **SNORT-1**: `fc00:0:6f::/64` (Connected to XR-6)
- **SNORT-2**: `fc00:0:7f::/64` (Connected to XR-7)

### Host IP Addresses
- **HOST-A**: `2001:db8:a::10`
- **HOST-B**: `2001:db8:b::10`
- **HOST-C**: `2001:db8:c::10`

### Configuration Files
- All configuration files are located in the [config](../config/) folder.

### Service Configuration
- Services **SERA1**, **SERA2**, **SNORT1**, and **SNORT2** are running in host-mode with a [Consul](https://www.consul.io/) agent using the host's IP address.
- Each service requires its own external IP for Consul service distinction.
- The Consul agent connects to a Consul server running on an external Kubernetes cluster. More details are available in the [deployment repository](https://github.com/hawkv6/deployment).
- Services are configured with the `ip route` command to be SR-aware. See `config/<service>/<service>.cfg` for details.
- Consul configuration files can be found in `config/<service>/<service>.json` and `config/<service>/consul.hcl`.

### Telemetry and BMP Data
- XRd routers send telemetry data to a [Jalapeno](https://github.com/cisco-open/jalapeno) Telegraf instance.
- XR-4 has a BGP session with XR-5 and sends BMP data to Jalapeno goBMP.

### Application Bindings
- **HOST-A**, **HOST-B**, and **HOST-C** bind the [hawkwing](https://github.com/hawkv6/hawkwing) application with configuration from `../hawkwing`.
- **HAWK-EYE** binds the [hawkeye](https://github.com/hawkv6/hawkeye) application from `../hawkeye`.

### Lab Impairments Scripts
- Use `set-lab-impairments.sh` and `remove-lab-impairments.sh` in the `config` folder to manage lab impairments using [clab-telemetry-linker](https://github.com/hawkv6/clab-telemetry-linker).
- For an overview of the network with impairments, refer to [impairments](impairments.md).

### Flexible Algorithms
- For an overview of the applied FlexAlgos in the network, refer to [flex-algo](flex-algo.md).
