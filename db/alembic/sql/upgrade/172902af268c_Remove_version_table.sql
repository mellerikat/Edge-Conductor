-- Running upgrade 93b8136d4f54 -> 172902af268c

DROP TABLE version;

UPDATE alembic_version SET version_num='172902af268c' WHERE alembic_version.version_num = '93b8136d4f54';

