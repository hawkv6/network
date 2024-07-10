sudo clab-telemetry-linker set -n XR-1 -i Gi0-0-0-1 -d 4 
sudo clab-telemetry-linker set -n XR-1 -i Gi0-0-0-2 -d 6 -l 3
sudo clab-telemetry-linker set -n XR-2 -i Gi0-0-0-0 -d 3
sudo clab-telemetry-linker set -n XR-2 -i Gi0-0-0-1 -d 8 
sudo clab-telemetry-linker set -n XR-3 -i Gi0-0-0-0 -d 5 -l 3
sudo clab-telemetry-linker set -n XR-3 -i Gi0-0-0-3 -d 8 
sudo clab-telemetry-linker set -n XR-5 -i Gi0-0-0-1 -l 2
sudo clab-telemetry-linker set -n XR-5 -i Gi0-0-0-2 -l 2
sudo clab-telemetry-linker set -n XR-6 -i Gi0-0-0-2 -l 2 -r 10000
sudo clab-telemetry-linker set -n XR-6 -i Gi0-0-0-0 -d 8 
sudo clab-telemetry-linker set -n XR-6 -i Gi0-0-0-1 -l 2
sudo clab-telemetry-linker set -n XR-6 -i Gi0-0-0-2 -l 2 -r 10000
sudo clab-telemetry-linker set -n XR-6 -i Gi0-0-0-3 -d 2
sudo clab-telemetry-linker set -n XR-6 -i Gi0-0-0-4 -l 3 -r 100000
sudo clab-telemetry-linker set -n XR-7 -i Gi0-0-0-0 -d 8
sudo clab-telemetry-linker set -n XR-7 -i Gi0-0-0-1 -l 2
sudo clab-telemetry-linker set -n XR-7 -i Gi0-0-0-2 -r 10000 
sudo clab-telemetry-linker set -n XR-7 -i Gi0-0-0-3 -r 100000 
sudo clab-telemetry-linker set -n XR-7 -i Gi0-0-0-4 -r 100000 
sudo clab-telemetry-linker set -n XR-8 -i Gi0-0-0-0 -d 2
sudo clab-telemetry-linker set -n XR-8 -i Gi0-0-0-1 -r 100000
sudo clab-telemetry-linker set -n XR-8 -i Gi0-0-0-2 -l 2
sudo clab-telemetry-linker set -n XR-8 -i Gi0-0-0-3 -l 2
sudo clab-telemetry-linker set -n SITE-B -i Gi0-0-0-0 -l 2
sudo clab-telemetry-linker set -n SITE-B -i Gi0-0-0-2 -l 3 -r 100000
sudo clab-telemetry-linker set -n SITE-C -i Gi0-0-0-2 -r 100000

sudo clab-telemetry-linker show -n XR-1
sleep 1
sudo clab-telemetry-linker show -n XR-2
sleep 1
sudo clab-telemetry-linker show -n XR-3
sleep 1
sudo clab-telemetry-linker show -n XR-6
sleep 1
sudo clab-telemetry-linker show -n XR-7
sleep 1
sudo clab-telemetry-linker show -n XR-8
sleep 1
sudo clab-telemetry-linker show -n SITE-B
sleep 1
sudo clab-telemetry-linker show -n SITE-C
sleep 1
