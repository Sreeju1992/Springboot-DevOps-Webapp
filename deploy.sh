#!/bin/bash

# Variables
REPO_URL="https://github.com/Sreeju1992/Springboot-DevOps-Webapp.git"  # Repository URL
CLONE_DIR="your-directory"  # Directory where the repo will be cloned
HELM_RELEASE_NAME="hello-rakbank"
HELM_CHART_PATH="./charts/Springboot-app"
NAMESPACE="default"
IMAGE_TAG="v2"
REPOSITORY="sreejith92"
IMAGE_NAME="hellorakbank"

# Check if Git is installed
if ! command -v git &> /dev/null
then
    echo "Git is not installed. Please install Git first."
    exit 1
fi

# Check if Helm is installed
if ! command -v helm &> /dev/null
then
    echo "Helm is not installed. Please install Helm first."
    exit 1
fi

# Clone the repository
if [ ! -d "${CLONE_DIR}" ]; then
    echo "Cloning repository..."
    git clone ${REPO_URL} ${CLONE_DIR}
    if [ $? -ne 0 ]; then
        echo "Failed to clone repository. Exiting."
        exit 1
    fi
fi

# Change to the repository directory
cd ${CLONE_DIR}

# Create namespace if not exists
kubectl get namespace ${NAMESPACE} >/dev/null 2>&1 || kubectl create namespace ${NAMESPACE}


# Install or Upgrade the Helm chart
echo "Deploying Helm chart..."
helm upgrade --install ${HELM_RELEASE_NAME} ${HELM_CHART_PATH} \
    --namespace ${NAMESPACE} \
    --set image.repository=${REPOSITORY}/${IMAGE_NAME} \
    --set image.tag=${IMAGE_TAG}

# Check deployment status
echo "Checking deployment status..."
kubectl rollout status deployment/${HELM_RELEASE_NAME} --namespace ${NAMESPACE}
