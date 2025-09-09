create user whuser with password 'whuserpassword';
GRANT USAGE ON SCHEMA public TO whuser ;
GRANT CREATE ON SCHEMA public TO whuser ;
CREATE DATABASE wh OWNER whuser;