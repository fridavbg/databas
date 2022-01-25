


# MARIADB
#### START:
```
brew services start mariadb
mysql.server start
```

#### LOGIN:
```
Sudo - datalösenord först
mariadb -u root -p
```

#### STOP:
```
brew services stop mariadb
mysql.server stop
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

