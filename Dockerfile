ARG TF_SERVING_VERSION=latest
ARG TF_SERVING_BUILD_IMAGE=tensorflow/serving:${TF_SERVING_VERSION}-devel

FROM ${TF_SERVING_BUILD_IMAGE} as build_image
FROM heroku/heroku:18

ARG TF_SERVING_VERSION_GIT_BRANCH=master
ARG TF_SERVING_VERSION_GIT_COMMIT=head
ARG MODEL_NAME=deblurrer

LABEL maintainer="Whitman Bohorquez"
LABEL tensorflow_serving_github_branchtag=${TF_SERVING_VERSION_GIT_BRANCH}
LABEL tensorflow_serving_github_commit=${TF_SERVING_VERSION_GIT_COMMIT}

RUN apt-get update && \
apt-get install -y --no-install-recommends ca-certificates git && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

# Install TF Serving pkg and build context
COPY --from=build_image /usr/local/bin/tensorflow_model_server /usr/bin/tensorflow_model_server
COPY / /

# Create a script that runs the model server so we can use environment variables
# while also passing in arguments from the docker command line
RUN echo '#!/bin/bash \n\n\
tensorflow_model_server \
--port=8500 --rest_api_port=$PORT \
--model_name=${MODEL_NAME} --model_base_path=/models/${MODEL_NAME} \
"$@"' > /usr/bin/tf_serving_entrypoint.sh \
&& chmod +x /usr/bin/tf_serving_entrypoint.sh

ENTRYPOINT ["/usr/bin/tf_serving_entrypoint.sh"]