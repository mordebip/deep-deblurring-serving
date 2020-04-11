FROM tensorflow/serving
LABEL maintainer="Whitman Bohorquez" description="Build tf serving based image. This repo must be used as build context"
COPY / /
RUN apt-get update && apt-get install -y git && git reset --hard

ENV MODEL_NAME=deblurrer MODEL_BASE_PATH=/models

RUN echo '#!/bin/bash \n\n\
tensorflow_model_server \
--rest_api_port=$PORT \
--model_name=${MODEL_NAME} \
--model_base_path=${MODEL_BASE_PATH}/${MODEL_NAME} \
"$@"' > /usr/bin/tf_serving_entrypoint.sh \
&& chmod +x /usr/bin/tf_serving_entrypoint.sh

# CMD is required to run on Heroku
CMD ["/usr/bin/tf_serving_entrypoint.sh"]

# Setup bash as default
RUN rm /bin/sh && ln -s /bin/bash /bin/sh