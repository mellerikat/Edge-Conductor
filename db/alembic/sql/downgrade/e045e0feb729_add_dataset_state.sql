-- Running downgrade e045e0feb729 -> 1fb0e6da11df

CREATE INDEX name ON dataset (name);

ALTER TABLE dataset DROP COLUMN dataset_state;

UPDATE alembic_version SET version_num='1fb0e6da11df' WHERE alembic_version.version_num = 'e045e0feb729';

