-- Running upgrade ac600f662cc5 -> 1fb0e6da11df

DROP INDEX name ON stream;

UPDATE alembic_version SET version_num='1fb0e6da11df' WHERE alembic_version.version_num = 'ac600f662cc5';

