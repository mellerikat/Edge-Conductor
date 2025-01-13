-- Running downgrade bf91e2b5bb73 -> 8bba5ea98235

CREATE INDEX edge_id ON edge (edge_id);

UPDATE alembic_version SET version_num='8bba5ea98235' WHERE alembic_version.version_num = 'bf91e2b5bb73';

