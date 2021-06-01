# Prepare for a k3s cluster
## Specifications
- **Host OS**: windows 64 bits
- **Guest OS**: ubuntu-16.04.7-server-amd64 (1 master and 2 workers)
- **Software**: virtualbox

## Prerequisite
- Windows PC 64 bits with:
  - Free RAM > 6GB
  - Free DISK > 45GB
- [virtualbox](https://www.virtualbox.org/wiki/Downloads) installed
- [packer](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli) download and setup PATH environment

## Setup steps

1. download image file "ubuntu-16.04.7-server-amd64.iso" into folder **"windows"**
   - ISO: [ubuntu-16.04.7-server-amd64.iso](http://releases.ubuntu.com/xenial/ubuntu-16.04.7-server-amd64.iso)
   - Torrent: [ubuntu-16.04.7-server-amd64.iso.torrent](http://releases.ubuntu.com/xenial/ubuntu-16.04.7-server-amd64.iso.torrent) (Recommended)
   - Or choose from http://releases.ubuntu.com/xenial/
2. Change ADAPTER_NAME in **build_import_start.cmd** to match your environment
   - Find your adapter name in "Control Panel\Network and Internet\Network Connections"
   - Choose adapter you use to access the internet
   - Right click and select "Properties"
   - Replace "TP-LINK 802.11ac Network Adapter" with your adapter name
    ![](./adapter%20properties.png)
3. Execute **build_import_start.cmd**
4. Success looks like below
    ![](./virtualbox%20success.png)