-- Running downgrade 93b8136d4f54 -> 91f22e8a97c9

DROP TABLE config;

UPDATE alembic_version SET version_num='91f22e8a97c9' WHERE alembic_version.version_num = '93b8136d4f54';

