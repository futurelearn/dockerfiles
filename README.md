# dockerfiles

A collection of Dockerfiles for FutureLearn builds.

## Building an image

Ensure you have [Docker installed](https://docs.docker.com/install/).

Move into the directory of the image you wish to build and run:

`docker build --rm futurelearn/<name of image>:<tag> .`

The image will be available for you to use locally.

## Pushing an image to Docker Hub

Sometimes you want to be able to test an image in an environment without pushing
to master and relying on Drone to build the latest image.

Ensure you have an account on [Docker Hub](https://hub.docker.com/).

Once you have an account, ask an admin to give you access to the [FutureLearn
Docker Hub Repository](https://hub.docker.com/u/futurelearn).

To push an image, run:

`docker push futurelearn/<name of image>:<tag>`

**Please ensure that you set a tag! If a tag is omitted then it will be set
as 'latest' which could cause confusion with someone else pulling an image**
