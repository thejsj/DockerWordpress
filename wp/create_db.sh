#!/bin/bash
params=" -u ${DB_USER} -p${DB_PASS} -h ${DB_HOST} "

# Create Database
mysql $params <<DELIMITER
CREATE DATABASE IF NOT EXISTS $DB_NAME;
DELIMITER

# Grant Options (Creates User Automatically)
# http://stackoverflow.com/questions/4528393/mysql-create-user-only-when-the-user-doesnt-exist
mysql $params <<DELIMITER
GRANT ALL PRIVILEGES ON $DB_NAME.*
TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS'
WITH GRANT OPTION;
DELIMITER

mysql $params <<DELIMITER
GRANT ALL PRIVILEGES ON $DB_NAME.*
TO '$DB_USER'@'$DB_HOST' IDENTIFIED BY '$DB_PASS'
WITH GRANT OPTION;
DELIMITER

mysql $params <<DELIMITER
GRANT ALL PRIVILEGES ON $DB_NAME.*
TO '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS'
WITH GRANT OPTION;
DELIMITER

mysql $params <<DELIMITER
GRANT ALL PRIVILEGES ON $DB_NAME.*
TO '$DB_USER'@'127.0.0.1' IDENTIFIED BY '$DB_PASS'
WITH GRANT OPTION;
DELIMITER