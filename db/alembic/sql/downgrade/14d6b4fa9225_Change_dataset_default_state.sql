-- Running downgrade 14d6b4fa9225 -> de1087c151d7

ALTER TABLE dataset ADD COLUMN is_completed TINYINT(1);

ALTER TABLE dataset ALTER COLUMN dataset_state SET DEFAULT 'available';

UPDATE alembic_version SET version_num='de1087c151d7' WHERE alembic_version.version_num = '14d6b4fa9225';

