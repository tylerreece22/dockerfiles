# https://www.digitalocean.com/community/tutorials/how-to-use-mysql-query-profiling
SET SESSION profiling = 1;
SET profiling = 1;
set profiling = 0; # disable profiling
show profiles;
SELECT * FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID=#; # id number from slow_query_log

SET GLOBAL slow_query_log = 'ON';
SET GLOBAL slow_query_log_file = '/var/log/mysql/localhost-slow.log';
SET GLOBAL log_queries_not_using_indexes = 'ON';
SET SESSION long_query_time = 1;
SET SESSION min_examined_row_limit = 100;

SHOW GLOBAL VARIABLES LIKE 'slow_query_log';
SHOW SESSION VARIABLES LIKE 'long_query_time';