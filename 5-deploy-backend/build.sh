#!/bin/sh

# export the environment variables declared in .env
export $(grep -v '^#' .env | xargs)

ls templates/deployment.yaml | xargs sed \
-e "s|{{GCP_CONTAINER_REGISTRY_HOSTNAME}}|"${GCP_CONTAINER_REGISTRY_HOSTNAME}"|g"  \
-e "s|{{PROJECT_ID}}|"${PROJECT_ID}"|g"  \
-e "s|{{APP_NAME}}|"${APP_NAME}"|g"  \
-e "s|{{ENV_NAME}}|"${ENV_NAME}"|g"  \
-e "s|{{TARGET_BUILD_IMAGE_NAME}}|"${TARGET_BUILD_IMAGE_NAME}"|g"  \
-e "s|{{TARGET_BUILD_IMAGE_VERSION}}|"${TARGET_BUILD_IMAGE_VERSION}"|g"  \
-e "s|{{APP_MIN_REPLICAS}}|"${APP_MIN_REPLICAS}"|g"  \
-e "s|{{APP_MAX_REPLICAS}}|"${APP_MAX_REPLICAS}"|g"  \
> "manifests/${APP_NAME}-${ENV_NAME}.yaml"

# build from the ./Docker directory
#docker build --tag "${TARGET_BUILD_IMAGE_NAME}":"${TARGET_BUILD_IMAGE_VERSION}" Docker

# push to GCP container registry
#docker push "${GCP_CONTAINER_REGISTRY_HOSTNAME}"/"${PROJECT_ID}"/"${TARGET_BUILD_IMAGE_NAME}":"${TARGET_BUILD_IMAGE_VERSION}"
