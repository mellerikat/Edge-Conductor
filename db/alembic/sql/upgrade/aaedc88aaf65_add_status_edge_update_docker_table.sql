-- Running upgrade f8edcb978846 -> aaedc88aaf65

ALTER TABLE edge_update_docker ADD COLUMN version_seq INTEGER;

ALTER TABLE edge_update_docker ADD COLUMN status VARCHAR(32);

ALTER TABLE edge_update_docker ADD FOREIGN KEY(version_seq) REFERENCES edge_update_version (seq);

UPDATE alembic_version SET version_num='aaedc88aaf65' WHERE alembic_version.version_num = 'f8edcb978846';

