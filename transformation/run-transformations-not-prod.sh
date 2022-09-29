#! /bin/bash

source .env

docker pull ghcr.io/dbt-labs/dbt-postgres:1.2.latest 

environment=not-prod

docker run -it \
    --network=host \
    --mount type=bind,source=/Users/emmacorbett/Documents/work-projects/home-office/dbt-proto/transformation,target=/usr/app/dbt \
    --mount type=bind,source=/Users/emmacorbett/Documents/work-projects/home-office/dbt-proto/transformation/profiles,target=/root/.dbt/ \
    --env DBT_TARGET=$environment \
    --env DBT_USER=$username \
    --env DBT_ENV_SECRET_PASSWORD=$password \
    ghcr.io/dbt-labs/dbt-postgres \
    run