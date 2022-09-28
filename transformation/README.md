### Add a profile
```sh
cp ./profiles/profiles.example ./profiles/profiles.yml
```
Then add credentials to the RDS instances.

### Run trnasformations
```sh
dbt run --profiles-dir ./profiles
```

### Run tests
```sh
dbt test --profiles-dir ./profiles
```