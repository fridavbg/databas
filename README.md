


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
mariadb --table <DBName> < <FILENAME>.sql
```

