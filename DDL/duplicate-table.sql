-- PostgresSQL: Copies table structure and constraint(primary key) not foerign key
create table replica_table (like parent_table including all);

-- MySQL
create table replica_table like parent_table;

-- Copy all parent data into replica
select * from parent_table insert into replica_table;