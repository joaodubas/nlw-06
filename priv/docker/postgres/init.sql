CREATE EXTENSION "uuid-ossp";
CREATE EXTENSION "pg_stat_statements";
CREATE EXTENSION "btree_gist";
CREATE DATABASE wabanex_dev TEMPLATE postgres;
CREATE DATABASE wabanex_test TEMPLATE wabanex_dev;
