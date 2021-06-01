:: adjust parameter here
SET VM_NAME_1=kubemaster
SET VM_NAME_2=kubenode1
SET VM_NAME_3=kubenode2

SET IP_1=192.168.1.61
SET IP_2=192.168.1.62
SET IP_3=192.168.1.63

SET MAC_1=0800279E5D51
SET MAC_2=0800279E5D52
SET MAC_3=0800279E5D53

:: set network adapter you want to use
SET ADAPTER_NAME=TP-LINK 802.11ac Network Adapter
SET HOST_NAME_1=%VM_NAME_1%
SET HOST_NAME_2=%VM_NAME_2%
SET HOST_NAME_3=%VM_NAME_3%

:: build images
packer build -var "vm_name=%VM_NAME_1%" -var "hostname=%HOST_NAME_1%" -var "ip=%IP_1%" -var "adapter=%ADAPTER_NAME%" -var "mac=%MAC_1%" template.json
packer build -var "vm_name=%VM_NAME_2%" -var "hostname=%HOST_NAME_2%" -var "ip=%IP_2%" -var "adapter=%ADAPTER_NAME%" -var "mac=%MAC_2%" template.json
packer build -var "vm_name=%VM_NAME_3%" -var "hostname=%HOST_NAME_3%" -var "ip=%IP_3%" -var "adapter=%ADAPTER_NAME%" -var "mac=%MAC_3%" template.json

:: import images
VBoxManage import output-%VM_NAME_1%/%VM_NAME_1%.ovf --vsys 0 --unit 4 --ignore
VBoxManage import output-%VM_NAME_2%/%VM_NAME_2%.ovf --vsys 0 --unit 4 --ignore
VBoxManage import output-%VM_NAME_3%/%VM_NAME_3%.ovf --vsys 0 --unit 4 --ignore

VBoxManage modifyvm %VM_NAME_1% --nic1 none
VBoxManage modifyvm %VM_NAME_2% --nic1 none
VBoxManage modifyvm %VM_NAME_3% --nic1 none

:: start images
VBoxManage startvm %VM_NAME_1% --type headless
VBoxManage startvm %VM_NAME_2% --type headless
VBoxManage startvm %VM_NAME_3% --type headless