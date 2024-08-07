### clabshark 

I wrote the following little bash function to simplify remote capture:
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
#### Usage
Here is an example of sniffing on XR-1 GigabitEthernet0/0/0/0:
```
clabshark user@clab-server clab-hawkv6-XR-1 Gi0-0-0-0
```
#### Adding to `.bashrc`
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