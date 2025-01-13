-- Running downgrade 1fb0e6da11df -> ac600f662cc5

CREATE INDEX name ON stream (name);

UPDATE alembic_version SET version_num='ac600f662cc5' WHERE alembic_version.version_num = '1fb0e6da11df';

