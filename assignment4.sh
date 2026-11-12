log "Creating virtual network and default subnet: ${VNET_NAME}"
az network vnet create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VNET_NAME" \
  --location "$LOCATION" \
  --address-prefixes "$ADDRESS_PREFIX" \
  --subnet-name "$SUBNET_NAME" \
  --subnet-prefixes "$SUBNET_PREFIX" \
  --output none

# Validate deployed resources and show a compact dashboard.
log "Validating deployment..."
RG_STATE="$(az group show --name "$RESOURCE_GROUP" --query properties.provisioningState -o tsv)"
STORAGE_STATE="$(az storage account show --name "$STORAGE_ACCOUNT" --resource-group "$RESOURCE_GROUP" --query provisioningState -o tsv)"
VNET_STATE="$(az network vnet show --resource-group "$RESOURCE_GROUP" --name "$VNET_NAME" --query provisioningState -o tsv)"
VNET_CIDR="$(az network vnet show --resource-group "$RESOURCE_GROUP" --name "$VNET_NAME" --query addressSpace.addressPrefixes[0] -o tsv)"
SUBNET_CIDR="$(az network vnet subnet show --resource-group "$RESOURCE_GROUP" --vnet-name "$VNET_NAME" --name "$SUBNET_NAME" --query addressPrefix -o tsv)"

printf '\n============================================================\n'
printf '       AZURE ENVIRONMENT DEPLOYMENT - VALIDATION DASHBOARD\n'
printf '============================================================\n'
printf '%-22s %-34s %s\n' "RESOURCE" "NAME / CONFIGURATION" "STATUS"
printf '%-22s %-34s %s\n' "Resource Group" "$RESOURCE_GROUP" "$RG_STATE"
printf '%-22s %-34s %s\n' "Storage Account" "$STORAGE_ACCOUNT" "$STORAGE_STATE"
printf '%-22s %-34s %s\n' "Virtual Network" "$VNET_NAME" "$VNET_STATE"
printf '%-22s %-34s %s\n' "VNet Address Space" "$VNET_CIDR" "CONFIGURED"
printf '%-22s %-34s %s\n' "Default Subnet" "$SUBNET_NAME ($SUBNET_CIDR)" "CONFIGURED"
printf '------------------------------------------------------------\n'
printf 'Subscription: %s\nRegion:       %s\n' "$SUBSCRIPTION_NAME" "$LOCATION"
printf '============================================================\n'

[[ "$RG_STATE" == "Succeeded" && "$STORAGE_STATE" == "Succeeded" && "$VNET_STATE" == "Succeeded" ]] \
  || fail "One or more resources did not reach the Succeeded state. Review the Azure CLI output."
log "Deployment completed successfully."
