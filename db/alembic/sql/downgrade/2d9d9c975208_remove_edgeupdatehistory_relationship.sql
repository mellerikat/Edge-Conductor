-- Running downgrade 2d9d9c975208 -> 5e574d6b2258

ALTER TABLE edge_update_history ADD COLUMN version_seq INTEGER;

ALTER TABLE edge_update_history ADD CONSTRAINT edge_update_history_ibfk_1 FOREIGN KEY(edge_seq) REFERENCES edge (seq);

ALTER TABLE edge_update_history ADD CONSTRAINT edge_update_history_ibfk_2 FOREIGN KEY(version_seq) REFERENCES edge_update_version (seq);

ALTER TABLE edge_update_history MODIFY edge_seq INTEGER NULL;

ALTER TABLE edge_update_history DROP COLUMN version;

UPDATE alembic_version SET version_num='5e574d6b2258' WHERE alembic_version.version_num = '2d9d9c975208';

