-- Running upgrade 1fb0e6da11df -> e045e0feb729

ALTER TABLE dataset ADD COLUMN dataset_state VARCHAR(16) NOT NULL DEFAULT 'available';

DROP INDEX name ON dataset;

UPDATE alembic_version SET version_num='e045e0feb729' WHERE alembic_version.version_num = '1fb0e6da11df';

