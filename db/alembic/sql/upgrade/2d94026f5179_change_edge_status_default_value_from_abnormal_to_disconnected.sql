-- Running upgrade 720091f8573c -> 2d94026f5179

ALTER TABLE edge ALTER COLUMN edge_status SET DEFAULT 'disconnected';

UPDATE alembic_version SET version_num='2d94026f5179' WHERE alembic_version.version_num = '720091f8573c';

