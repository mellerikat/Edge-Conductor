-- Running upgrade 5e574d6b2258 -> 2d9d9c975208

ALTER TABLE edge_update_history ADD COLUMN version VARCHAR(32) NOT NULL;

ALTER TABLE edge_update_history MODIFY edge_seq INTEGER NOT NULL;

ALTER TABLE edge_update_history DROP FOREIGN KEY edge_update_history_ibfk_2;

ALTER TABLE edge_update_history DROP FOREIGN KEY edge_update_history_ibfk_1;

ALTER TABLE edge_update_history DROP COLUMN version_seq;

UPDATE alembic_version SET version_num='2d9d9c975208' WHERE alembic_version.version_num = '5e574d6b2258';

