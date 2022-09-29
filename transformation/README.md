## Create dotenv file
```sh
cp ./.env.example ./.env
```
Then add credentials to the RDS instances.

## Install dbt
```sh
brew install dbt-postgres
```

## Run transformations

### Using docker
```sh
./run-transformations-not-prod.sh
```

### Using cli (installed via homebrew)
```sh
dbt run --profiles-dir ./profiles
```


## Run tests

```sh
./run-tests.sh
```