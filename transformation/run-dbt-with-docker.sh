#! /bin/bash


docker pull ghcr.io/dbt-labs/dbt-postgres:1.2.latest 

docker run -it \
    --network=host \
    --mount type=bind,source=/Users/emmacorbett/Documents/work-projects/home-office/dbt-proto/transformation,target=/usr/app/dbt \
    --mount type=bind,source=/Users/emmacorbett/Documents/work-projects/home-office/dbt-proto/transformation/profiles,target=/root/.dbt/ \
    ghcr.io/dbt-labs/dbt-postgres \
    run