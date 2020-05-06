FROM tensorflow/serving
LABEL maintainer="Whitman Bohorquez"

COPY / /

# Create a script that runs the model server so we can use environment variables
# while also passing in arguments from the docker command line
RUN echo '#!/bin/bash \n\n\
tensorflow_model_server \
--port=8500 --rest_api_port=$PORT \
--model_name=$MODEL_NAME --model_base_path=/models/$MODEL_NAME \
"$@"' > /usr/bin/tf_serving_entrypoint.sh \
&& chmod +x /usr/bin/tf_serving_entrypoint.sh