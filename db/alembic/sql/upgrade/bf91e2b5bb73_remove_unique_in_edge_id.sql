-- Running upgrade 8bba5ea98235 -> bf91e2b5bb73

DROP INDEX edge_id ON edge;

UPDATE alembic_version SET version_num='bf91e2b5bb73' WHERE alembic_version.version_num = '8bba5ea98235';

