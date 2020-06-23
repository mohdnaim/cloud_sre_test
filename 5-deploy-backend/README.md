# NodeJS Backend

This will build and deploy NodeJS backend into a specific namespace/environment in the Kubernetes cluster

## Steps:

1. Create .env file

2. Required variables description:

    1. PROJECT_NAME=airasia-cloud-sre-test
        - name of the project created in GCP
    2. PROJECT_ID=airasia-cloud-sre-test
        - ID of the project created in GCP
    3. GCP_CONTAINER_REGISTRY_HOSTNAME=asia.gcr.io
        - hostname of the GCP Container Registry
    4. ENV_NAME
        - environment name e.g. development, staging, production
    5. APP_NAME=backend
        - application name
    6. TARGET_BUILD_IMAGE_NAME=backend
        - name of the Docker image to be tagged
    7. TARGET_BUILD_IMAGE_VERSION=development
        - version of the Docker image to be tagged
    8. APP_MAX_REPLICAS
        - maximum number of replicas to be horizontally scaled
        - e.g. 10
    9. APP_MIN_REPLICAS
        - minimum number of replicas to be created
        - e.g. 2

3. Execute ./build.sh

4. The script does:
    - build a Docker image of the application
    - write a Kubernetes manifest for the application for a specific environment
    - push the Docker image to GCP Container Registry

