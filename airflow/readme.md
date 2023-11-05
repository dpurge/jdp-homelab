# Airflow configuration

## Build image

```sh
docker build --pull --rm -f "Dockerfile" -t dpurge/jdp-airflow:latest "." 
```

## Create PostgreSQL database

```sql
CREATE DATABASE airflow;
CREATE USER airflow WITH PASSWORD '******';
GRANT ALL PRIVILEGES ON DATABASE airflow TO airflow;

USE airflow;
GRANT ALL ON SCHEMA public TO airflow;
ALTER USER airflow SET search_path = public;
```

Connect to the database:

```cfg
postgresql+psycopg2://airflow:<password>@<host>/airflow
```

## Mount directories

- `/var/cronjob`
- `/var/jdpnas01`
- `/opt/airflow`
