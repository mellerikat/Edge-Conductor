-- Running downgrade 91f22e8a97c9 -> ad67f5e428a3

ALTER TABLE stream_schedule MODIFY stream_seq INTEGER NULL;

UPDATE alembic_version SET version_num='ad67f5e428a3' WHERE alembic_version.version_num = '91f22e8a97c9';

