#!/bin/sh

# export the environment variables declared in .env
export $(grep -v '^#' .env | xargs)

ls templates/namespace.yaml | xargs sed \
-e "s|{{ENV_NAME}}|"${ENV_NAME}"|g"  \
> "manifests/${ENV_NAME}.yaml"

# Create a namespace for the environment
kubectl apply -f manifests/"${ENV_NAME}".yaml
