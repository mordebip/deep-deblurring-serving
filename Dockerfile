FROM tensorflow/serving
LABEL maintainer="Whitman Bohorquez" description="Build tf serving based image. This repo must be used as build context"
COPY / /
RUN apt-get update && apt-get install -y git
