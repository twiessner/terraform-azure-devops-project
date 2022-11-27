#!/bin/sh

# Common variables
#
API_VERSION="7.1-preview"
BASIC_AUTH=":$AZURE_DEVOPS_PAT"
LIFECYCLE_ACTION="$1"

# Load the configured service endpoint details
# see: https://learn.microsoft.com/en-us/rest/api/azure/devops/serviceendpoint/endpoints/get-service-endpoints-by-names?view=azure-devops-rest-7.1&tabs=HTTP
#
SERVICE_ENDPOINT_URL="$BASE_URL/$PROJECT_ID/_apis/serviceendpoint/endpoints?endpointNames=$SERVICE_ENDPOINT_NAME&api-version=$API_VERSION"
SERVICE_ENDPOINT_RESULT=$(curl -L -s -u $BASIC_AUTH -H 'Accept:application/json' $SERVICE_ENDPOINT_URL)
SERVICE_ENDPOINT_ID=$(echo $SERVICE_ENDPOINT_RESULT | jq -r .value[0].id)

if [[ -z "$SERVICE_ENDPOINT_ID" ]]
then
  echo "Unable to find service endpoint '$SERVICE_ENDPOINT_NAME'. #please check your configuration."
  exit 1
fi
echo "Details for configured service endpoint '$SERVICE_ENDPOINT_NAME' -> id '$SERVICE_ENDPOINT_ID' have been loaded successfully."

# Modify the post data, by adding the referenced service_endpoint_id from step 1
#
POOL_REQUEST_BODY_JSON=$(echo $REQUEST_BODY_JSON | jq --arg endpoint_id "$SERVICE_ENDPOINT_ID" '. += {"serviceEndpointId":$endpoint_id}')

# Lifecycle 'create' agent pool
# see: https://learn.microsoft.com/en-us/rest/api/azure/devops/distributedtask/elasticpools/create?view=azure-devops-rest-7.1
#
if [[ "$LIFECYCLE_ACTION" == "create" ]]
then
  echo "Creating pool '$POOL_NAME'."
  POOL_CREATE_URL_PARAMS="poolName=$POOL_NAME&projectId=$PROJECT_ID&authorizeAllPipelines=true&autoProvisionProjectPools=true&api-version=$API_VERSION"
  POOL_CREATE_URL="$BASE_URL/_apis/distributedtask/elasticpools?$POOL_CREATE_URL_PARAMS"
  curl -L -s -X POST -u $BASIC_AUTH -H "Content-Type:application/json" -d "$POOL_REQUEST_BODY_JSON" $POOL_CREATE_URL
  exit 0;
fi

POOL_LIST_URL_PARAMS="api-version=$API_VERSION"
POOL_LIST_URL="$BASE_URL/_apis/distributedtask/elasticpools?$POOL_LIST_URL_PARAMS"
POOL_LIST_RESULT=$(curl -L -s -u $BASIC_AUTH -H 'Accept:application/json' $POOL_LIST_URL)
POOL_ID=$(echo $POOL_LIST_RESULT | jq -r --arg azureId "$VM_SCALE_SET_ID" '.value[] | select(.azureId==$azureId) | .poolId')

if [[ -z "$POOL_ID" ]]
then
  echo "Unable to find a pool_id required for next request."
  exit 1;
fi

# Lifecycle 'update' agent pool
# see: https://learn.microsoft.com/en-us/rest/api/azure/devops/distributedtask/elasticpools/update?view=azure-devops-rest-7.1
#
if [[ "$LIFECYCLE_ACTION" == "update" ]]
then
  echo "Updating pool '$POOL_NAME' -> id '$POOL_ID'."
  POOL_UPDATE_URL_PARAMS="api-version=$API_VERSION"
  POOL_UPDATE_URL="$BASE_URL/_apis/distributedtask/elasticpools/$POOL_ID?$POOL_UPDATE_URL_PARAMS"
  curl -L -s -X PATCH -u $BASIC_AUTH -H "Content-Type:application/json" -d "$POOL_REQUEST_BODY_JSON" $POOL_UPDATE_URL
  exit 0;
fi

# Lifecycle 'delete' agent pool
#
if [[ "$LIFECYCLE_ACTION" == "delete" ]]
then
  echo "Deleting pool '$POOL_NAME' -> id '$POOL_ID'."
  POOL_DELETE_URL_PARAMS="api-version=$API_VERSION"
  POOL_DELETE_URL="$BASE_URL/_apis/distributedtask/pools/$POOL_ID?$POOL_DELETE_URL_PARAMS"
  curl -L -s -X DELETE -u $BASIC_AUTH $POOL_DELETE_URL
  exit 0;
fi
