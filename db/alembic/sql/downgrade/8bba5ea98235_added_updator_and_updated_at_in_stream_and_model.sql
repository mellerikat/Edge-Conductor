-- Running downgrade 8bba5ea98235 -> e045e0feb729

ALTER TABLE stream DROP COLUMN updated_at;

ALTER TABLE stream DROP COLUMN updator;

ALTER TABLE model DROP COLUMN updated_at;

ALTER TABLE model DROP COLUMN updator;

UPDATE alembic_version SET version_num='e045e0feb729' WHERE alembic_version.version_num = '8bba5ea98235';

