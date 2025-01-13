-- Running downgrade d33651e19297 -> 14d6b4fa9225

ALTER TABLE dataset MODIFY size INTEGER NULL;

UPDATE alembic_version SET version_num='14d6b4fa9225' WHERE alembic_version.version_num = 'd33651e19297';

