This is an example of setting development environment using Docker compose.

Services:

    - Ruby
    - Postgres
    - Redis
    - Memcached
    - ElasticSearch

# Install docker

    See [Install Docker](https://docs.docker.com/engine/installation/)

# Get started

    docker-machine create default
    eval $(docker-machine env default)
    docker-compose build
    docker-compose up db redis memcached elasticsearch
    docker-compose run app

# References
    - [Set time in Docker container](https://www.ivankrizsan.se/2015/10/31/time-in-docker-containers/)
