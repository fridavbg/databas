


# MARIADB
#### START:
```
brew services start mariadb
```

#### LOGIN:
```
mariadb -u root -p
```

#### STOP:
```
brew services stop mariadb
```
#### FULL RESET of skolan.larare
```
mariadb --table skolan < ddl-larare.sql
mariadb --table skolan < insert-larare.sql
mariadb --table skolan < dml-update.sql
mariadb --table skolan < ddl-migrate.sql
```
#### RUN .sql files
```
mariadb --table < <FILENAME>.sql
```

# DOCKER

#### Init the container and read the files in sql.d/
```
docker-compose up -d mariadb
```
#### Stop and clean volumes
```
docker-compose down -v
```
#### Do it all on one line
```
docker-compose down -v && docker-compose up -d mariadb
```
# Connect to MariaDB
```
docker run --name mariadb -p 13307:3306 -e MARIADB_ROOT_PASSWORD=pass -d mariadb:latest
```

 # Open MariaDB bash in Docker 

```
docker exec -it mariadb bash
```

