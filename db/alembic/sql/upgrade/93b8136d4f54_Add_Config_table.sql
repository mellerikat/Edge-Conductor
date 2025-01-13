-- Running upgrade 91f22e8a97c9 -> 93b8136d4f54

CREATE TABLE config (
    `key` VARCHAR(32) NOT NULL, 
    value VARCHAR(256), 
    PRIMARY KEY (`key`)
);

UPDATE alembic_version SET version_num='93b8136d4f54' WHERE alembic_version.version_num = '91f22e8a97c9';

