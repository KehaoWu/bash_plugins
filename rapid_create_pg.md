# 快速创建新的pg测试数据库

```
#!/bin/bash

PG_USER=postgres
PG_HOST=localhost
PG_PORT=5432
PG_DTBS=old_db_name

NEW_PG_USER=postgres
NEW_PG_HOST=localhost
NEW_PG_PORT=5442
NEW_PG_DTBS=new_db_name

pg_dump -U $PG_USER -h $PG_HOST -p $PG_PORT $PG_DTBS > temp.${PG_DTBS}.sql

sudo docker run --name ${NEW_PG_DTBS}_standalone -p ${NEW_PG_PORT}:5432 -d postgres:10.5

echo "休眠30秒，给充足时间给docker启动."

sleep 30

echo "create database ${NEW_PG_DTBS}" | psql -U ${NEW_PG_USER} -h ${NEW_PG_HOST} -p ${NEW_PG_PORT}

psql -U $NEW_PG_USER -h $NEW_PG_HOST -p $NEW_PG_PORT ${NEW_PG_DTBS} < temp.${PG_DTBS}.sql

```
