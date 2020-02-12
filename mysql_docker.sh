#!/bin/bash

name='some-mysql'
datapath='/opt/data/mysql'

docker stop ${name}
docker rm ${name}
docker run \
 -p 3306:3306 \
 -v ${datapath}:/app \
 -e MYSQL_ALLOW_EMPTY_PASSWORD='yes' \
 --name ${name} \
 -d mysql:5.7 \
 --character-set-server=utf8mb4 \
 --collation-server=utf8mb4_unicode_ci


sleep 10

docker exec ${name} bash -c 'echo "max_allowed_packet=32M" >> /etc/mysql/mysql.conf.d/mysqld.cnf'
docker exec ${name} bash -c 'echo "sql_mode=ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" >> /etc/mysql/mysql.conf.d/mysqld.cnf'
docker exec ${name} bash -c 'echo "default-character-set=utf8mb4" >> /etc/mysql/conf.d/mysql.cnf' # 这里一定要写对文件，写错文件就不会work

docker restart ${name}

sleep 10 # 这里可以用更好的方法判断，这里比较粗糙

docker exec ${name} bash -c "echo \"show variables like '%character%';\" | mysql -uroot "
docker exec ${name} bash -c "echo \"create database wordpress DEFAULT CHARACTER SET utf8\" | mysql -uroot"
docker exec ${name} bash -c "mysql -uroot wordpress < /app/data.sql"
docker exec ${name} bash -c "mysql -uroot wordpress < /app/wordpress.sql"
