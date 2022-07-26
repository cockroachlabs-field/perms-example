CREATE DATABASE IF NOT EXISTS perms_example;

USE perms_example;

/*
DROP TABLE IF EXISTS perms_example.identity_instance CASCADE;
DROP TABLE IF EXISTS perms_example.role_instance CASCADE;
DROP TABLE IF EXISTS perms_example.permission_instance CASCADE;
DROP TABLE IF EXISTS perms_example.identity_role_assignment;
DROP TABLE IF EXISTS perms_example.identity_permission_assignment;
DROP TABLE IF EXISTS perms_example.role_permission_assignment;
DROP TABLE IF EXISTS perms_example.role_hierarchy;
*/

CREATE TABLE IF NOT EXISTS perms_example.identity_instance
(
    iid uuid DEFAULT gen_random_uuid() NOT NULL,
    identity_name varchar NOT NULL,
    PRIMARY KEY ( iid )
);

CREATE TABLE IF NOT EXISTS perms_example.role_instance
(
    rid uuid DEFAULT gen_random_uuid() NOT NULL,
    role_name varchar NOT NULL,
    PRIMARY KEY ( rid )
);

CREATE TABLE IF NOT EXISTS perms_example.permission_instance
(
    pid uuid DEFAULT gen_random_uuid() NOT NULL,
    permission_name varchar NOT NULL,
    PRIMARY KEY ( pid )
);

CREATE TABLE IF NOT EXISTS perms_example.identity_role_assignment
(
    iid uuid REFERENCES identity_instance ( iid ) NOT NULL,
    rid uuid REFERENCES role_instance ( rid ) NOT NULL,
    assignment_ts timestamp DEFAULT now(),
    PRIMARY KEY ( iid, rid )
);

CREATE TABLE IF NOT EXISTS perms_example.identity_permission_assignment
(
    iid uuid REFERENCES identity_instance ( iid ) NOT NULL,
    pid uuid REFERENCES permission_instance ( pid ) NOT NULL,
    assignment_ts timestamp DEFAULT now(),
    PRIMARY KEY ( iid, pid )
);

CREATE TABLE IF NOT EXISTS perms_example.role_permission_assignment
(
    rid uuid REFERENCES role_instance ( rid ) NOT NULL,
    pid uuid REFERENCES permission_instance ( pid ) NOT NULL,
    assignment_ts timestamp DEFAULT now(),
    PRIMARY KEY ( rid, pid )
);

CREATE TABLE IF NOT EXISTS perms_example.role_hierarchy
(
  parent_rid uuid REFERENCES role_instance ( rid ) NOT NULL,
  child_rid uuid REFERENCES role_instance ( rid ) NOT NULL,
  PRIMARY KEY ( parent_rid, child_rid )
);

