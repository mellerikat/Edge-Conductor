-- Running downgrade ad67f5e428a3 -> febbce35fa8e

DROP TABLE stream_schedule_edge;

DROP TABLE stream_schedule;

UPDATE alembic_version SET version_num='febbce35fa8e' WHERE alembic_version.version_num = 'ad67f5e428a3';

