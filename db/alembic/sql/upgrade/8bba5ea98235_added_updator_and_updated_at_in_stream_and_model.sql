-- Running upgrade e045e0feb729 -> 8bba5ea98235

ALTER TABLE model ADD COLUMN updator VARCHAR(32);

ALTER TABLE model ADD COLUMN updated_at DATETIME;

ALTER TABLE stream ADD COLUMN updator VARCHAR(32);

ALTER TABLE stream ADD COLUMN updated_at DATETIME;

UPDATE alembic_version SET version_num='8bba5ea98235' WHERE alembic_version.version_num = 'e045e0feb729';

