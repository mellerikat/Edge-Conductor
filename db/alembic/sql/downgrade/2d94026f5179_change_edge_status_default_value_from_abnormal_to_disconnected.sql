-- Running downgrade 2d94026f5179 -> 720091f8573c

ALTER TABLE edge ALTER COLUMN edge_status SET DEFAULT 'abnormal';

UPDATE alembic_version SET version_num='720091f8573c' WHERE alembic_version.version_num = '2d94026f5179';

