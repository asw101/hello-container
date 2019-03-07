# README

# clone, create group + registry, build

```bash
# clone application
git clone https://github.com/asw101/hello-container.git
cd hello-container/

# set bash variables
RESOURCE_GROUP='hello-container'
LOCATION='eastus'
RANDOM_STR='7ee9db'
if [ -z "$RANDOM_STR" ]; then RANDOM_STR=$(openssl rand -hex 3); else echo $RANDOM_STR; fi
CONTAINER_REGISTRY="acr${RANDOM_STR}"
CONTAINER_IMAGE='hello-container:latest'

# create resource group
az group create --name $RESOURCE_GROUP --location $LOCATION

# create azure container registry
az acr create -g $RESOURCE_GROUP -n $CONTAINER_REGISTRY --sku Basic --admin-enabled true

# build with acr
az acr build --registry $CONTAINER_REGISTRY --image $CONTAINER_IMAGE -f Dockerfile .

# enable admin credentials (optional)
# az acr update -n $CONTAINER_REGISTRY --admin-enabled true

# pull down, and run locally to test (optional)
# az acr login -g $RESOURCE_GROUP -n $CONTAINER_REGISTRY
# docker run --rm -it -p 8080:8080 "${CONTAINER_REGISTRY}.azurecr.io/${CONTAINER_IMAGE}"

CONTAINER_REGISTRY_PASSWORD=$(az acr credential show -n $CONTAINER_REGISTRY | jq -r .passwords[0].value)
```

# single container instance

This is for illustrative purposes only. This would deploy only the *application* container of our multi-container deployment. It also does not define any environment variables.

```bash
# create single-container instance
az container create --resource-group $RESOURCE_GROUP --location $LOCATION \
    --name aci${RANDOM_STR} \
    --image "${CONTAINER_REGISTRY}.azurecr.io/${CONTAINER_IMAGE}" \
    --registry-login-server "${CONTAINER_REGISTRY}.azurecr.io" \
    --registry-username $CONTAINER_REGISTRY \
    --registry-password $CONTAINER_REGISTRY_PASSWORD \
    --cpu 1 \
    --memory 1 \
    --ports 8080 \
    --dns-name-label aci${RANDOM_STR}

# delete single-container instance
az container delete --resource-group $RESOURCE_GROUP --name aci${RANDOM_STR} -y
```

# multi container instance

```bash
# replace values in yaml file with sed (on bsd/macOS, omit '' on gnu/Linux)
cp deploy-aci-example.yaml deploy-aci.yaml
sed -i '' "s/\$image/${CONTAINER_REGISTRY}.azurecr.io\/${CONTAINER_IMAGE}/" deploy-aci.yaml
sed -i '' "s/\$dnsNameLabel/aci${RANDOM_STR}/" deploy-aci.yaml
sed -i '' "s/\$server/${CONTAINER_REGISTRY}.azurecr.io/" deploy-aci.yaml
sed -i '' "s/\$username/$CONTAINER_REGISTRY/" deploy-aci.yaml
sed -i '' "s?\$password?${CONTAINER_REGISTRY_PASSWORD}?" deploy-aci.yaml
cat deploy-aci.yaml

# create multi-container instance
az container create --resource-group $RESOURCE_GROUP --name aci${RANDOM_STR} --file deploy-aci.yaml

# delete
az container delete --resource-group $RESOURCE_GROUP --name aci${RANDOM_STR} -y
```

# test

```bash
# show container events
az container show -g $RESOURCE_GROUP -n aci${RANDOM_STR} | jq .containers[0].instanceView.events[]

# show container logs
az container logs --resource-group $RESOURCE_GROUP --name aci${RANDOM_STR} --container-name application
az container logs --resource-group $RESOURCE_GROUP --name aci${RANDOM_STR} --container-name jaeger

CONTAINER_INSTANCE_IP_FQDN=$(az container show -g $RESOURCE_GROUP -n aci${RANDOM_STR} | jq -r .ipAddress.fqdn)

CONTAINER_INSTANCE_IP_FQDN=$(az container show -g $RESOURCE_GROUP -n aci${RANDOM_STR} | jq -r .ipAddress.ip)

# curl application
curl "${CONTAINER_INSTANCE_IP_FQDN}:8080"

# open application
echo "http://${CONTAINER_INSTANCE_IP_FQDN}:8080"

# open jaeger
echo "http://${CONTAINER_INSTANCE_IP_FQDN}:16686"
```
