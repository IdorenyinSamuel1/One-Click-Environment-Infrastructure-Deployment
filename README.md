# One-Click-Environment-Infrastructure-Deployment
Automated Azure cloud infrastructure provisioning using Bash and Azure CLI. The script creates a Resource Group, a globally unique Storage Account, and a Virtual Network with a default subnet, followed by deployment validation.


One-Click Environment Infrastructure Deployment
A Bash + Azure CLI automation project that provisions a small, standardized Azure environment for non-technical team members.
What it creates
- Resource group: Automated-Deployment-RG
- Storage account: a globally unique name generated from the mystorageaccount prefix
- Virtual network: Automated-Deployment-VNet
- Default subnet: default (10.10.1.0/24) inside 10.10.0.0/16
- Validation dashboard: displays resource provisioning states and network configuration
The storage account name is generated dynamically because Azure storage account names must be globally unique. The script also disables public blob access, requires HTTPS, and enforces TLS 1.2.
Prerequisites
1. An Azure subscription.
2. Azure CLI installed.
3. Bash (Linux, macOS, or Windows via WSL/Git Bash).
4. An Azure identity with permission to create resource groups, storage accounts, and virtual networks.
Run
az login
az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"
chmod +x assignment4.sh
./assignment4.sh
Choose a region by passing it as the first argument:
./assignment4.sh southafricanorth
Or set a default region with an environment variable:
AZURE_LOCATION=uksouth ./assignment4.sh
The default region is eastus.
Expected result
At the end, the script prints a validation dashboard showing the resource group, storage account, virtual network, address space, subnet, subscription, and deployment region.
Cleanup
This project creates billable Azure resources. When you no longer need the environment, remove the resource group and everything inside it:
az group delete --name Automated-Deployment-RG --yes --no-wait
Repository structure
one-click-environment-deployment/
├── assignment4.sh
└── README.md
Skills demonstrated
- Bash scripting and command-line arguments
- Azure CLI automation
- Resource group and storage account provisioning
- Virtual network and subnet configuration
- Basic cloud security defaults
- Deployment validation and operational reporting
Note: This script provisions a virtual network and subnet, not an Azure VPN gateway. A VPN gateway is a separate resource that can be added if the architecture requires site-to-site or point-to-site connectivity.
