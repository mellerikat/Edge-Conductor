-- Running downgrade febbce35fa8e -> bf91e2b5bb73

DROP TABLE edge_error;

UPDATE alembic_version SET version_num='bf91e2b5bb73' WHERE alembic_version.version_num = 'febbce35fa8e';

