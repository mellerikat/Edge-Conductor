-- Running upgrade ad67f5e428a3 -> 91f22e8a97c9

ALTER TABLE stream_schedule MODIFY stream_seq INTEGER NOT NULL;

UPDATE alembic_version SET version_num='91f22e8a97c9' WHERE alembic_version.version_num = 'ad67f5e428a3';

