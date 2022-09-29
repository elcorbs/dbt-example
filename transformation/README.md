## Add a profile
```sh
cp ./profiles/profiles.example ./profiles/profiles.yml
```
Then add credentials to the RDS instances.

## Install dbt
```sh
brew install dbt-postgres
```

## Run transformations

### Using docker
```sh
chmod +x ./run-dbt-with-docker.sh
./run-dbt-with-docker.sh
```

### Using cli (installed via homebrew)
```sh
dbt run --profiles-dir ./profiles
```


## Run tests

```sh
dbt test --profiles-dir ./profiles
```