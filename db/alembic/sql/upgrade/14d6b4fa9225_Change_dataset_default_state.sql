-- Running upgrade de1087c151d7 -> 14d6b4fa9225

UPDATE dataset SET dataset_state = 'deleted' where is_completed = 0;

ALTER TABLE dataset ALTER COLUMN dataset_state SET DEFAULT 'importing';

ALTER TABLE dataset DROP COLUMN is_completed;

UPDATE alembic_version SET version_num='14d6b4fa9225' WHERE alembic_version.version_num = 'de1087c151d7';

