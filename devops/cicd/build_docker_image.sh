#! /bin/bash -e

function usage {
    cat <<EOF
=============================================================================================
NAME: $0

DESCRIPTION:
    This script builds the typeorm-express-typescript docker image ad publishes it to AWS ECR.

USAGE:
    $0 AWS_PROFILE VERSION REPOSITORY_NAME

PARAMETERS:
    AWS_PROFILE: Refers to an existing AWS PROFILE tied to a specific account.
    
    VERSION: Refer to the newest tag to use for the Docker image that should be aligned with
             the application version.
    
    REPOSITORY_NAME: Refers to the ECR repository NAME in the specified AWS account.
=============================================================================================
EOF
}

# Initialize the script

AWS_PROFILE="$1"
VERSION="$2"
REPOSITORY_NAME="$3"

if [ -z "$AWS_PROFILE" ]; then
    echo -e  "[ERROR]: No AWS_PROFILE was specified.\n"
    usage
    exit 1
fi

if [ -z "$VERSION" ]; then
    echo -e  "[ERROR]: No VERSION was specified.\n"
    usage
    exit 2
fi

if [ -z "$REPOSITORY_NAME" ]; then
    echo -e  "[ERROR]: No REPOSITORY_NAME was specified.\n"
    usage
    exit 3
fi

# Logic starts here
ORIGINAL_DIR=`pwd`

if [ -d /tmp/crossbridge/typeorm-express-typescript ]; then
    rm -rf /tmp/crossbridge/typeorm-express-typescript
fi

git clone --depth 1 --single-branch --no-tags -b main \
    https://github.com/mkosir/typeorm-express-typescript.git \
    /tmp/crossbridge/typeorm-express-typescript

cd /tmp/crossbridge/typeorm-express-typescript

REPOSITORY_URI=`aws --profile "$AWS_PROFILE" \
    --query 'repositories[0].repositoryUri' \
    --output text ecr describe-repositories`

IMAGE="${REPOSITORY_URI}/typeorm-express-typescript:$VERSION"

docker buildx build \
    -t  "$IMAGE" \
    .

aws --profile "$AWS_PROFILE" ecr get-login-password | \
    docker login -u AWS --password-stdin \
    000000000000.dkr.ecr.us-east-1.localhost.localstack.cloud:4566/crossbridge

docker push "${IMAGE}"

cd "$ORIGINAL_DIR"
