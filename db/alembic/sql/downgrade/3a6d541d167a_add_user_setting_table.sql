-- Running downgrade 3a6d541d167a -> aaedc88aaf65

DROP TABLE user_setting;

UPDATE alembic_version SET version_num='aaedc88aaf65' WHERE alembic_version.version_num = '3a6d541d167a';

