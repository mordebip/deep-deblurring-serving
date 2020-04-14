FROM tensorflow/serving
LABEL maintainer="Whitman Bohorquez" description="Build tf serving based image. This repo must be used as build context"

ENV MODEL_NAME=deblurrer

COPY / /

# Install git and dependecies for heroku exec
RUN apt-get update \
&& apt-get install -y git \
&& apt-get install -y curl \
&& apt-get install -y openssh-server

# Updates listening ports
RUN echo '#!/bin/bash \n\n\
tensorflow_model_server \
--rest_api_port=$PORT \
--model_name=${MODEL_NAME} \
--model_base_path=/models/${MODEL_NAME} \
"$@"' > /usr/bin/tf_serving_entrypoint.sh \
&& chmod +x /usr/bin/tf_serving_entrypoint.sh