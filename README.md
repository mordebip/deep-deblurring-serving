# Deep Deblurring Serving
The purpose of Deep Deblurring Serving is to store and distribute [Deep Deblurring Model](https://github.com/ElPapi42/deep-deblurring-model) architecture versions and successful training iterations.

The Serving strategy consists of a [Tensorflow Serving](https://www.tensorflow.org/tfx/guide/serving) Docker Container build with this Repository as Context, bringing the model iterations with it. This Docker Container can be deployed to any Cloud Service (GCloud, Azure, AWS, Heroku), and use the [Tensorflow Serving Rest API Specification](https://www.tensorflow.org/tfx/serving/api_rest) for request predictions.

On the next visualization, the block named as "Model Serving" is the System Component of Deep Deblurring Project stored in this repository, taking new model versions from Google Colab Training Pipeline, and serving the [Deep Deblurring Backend](https://github.com/ElPapi42/deep-deblurring-backend) API

![Image](https://github.com/ElPapi42/deep-deblurring/blob/master/system_architecture.png "Arch")

Currently, the container is deployed to Heroku, but we plan to Deploy the Serving API to other Cloud Platform like Azure. You can consult the details of the Docker Image building process on the [Dockerfile](https://github.com/ElPapi42/deep-deblurring-serving/blob/master/Dockerfile) which just take Tensorflow Serving Base Docker Image and apply some modifications to it.
