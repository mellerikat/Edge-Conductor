-- Running upgrade 2d9d9c975208 -> c54d6cd17365

ALTER TABLE edge_update_history MODIFY edge_seq INTEGER NULL;

ALTER TABLE edge_update_history ADD FOREIGN KEY(edge_seq) REFERENCES edge (seq);

UPDATE alembic_version SET version_num='c54d6cd17365' WHERE alembic_version.version_num = '2d9d9c975208';

