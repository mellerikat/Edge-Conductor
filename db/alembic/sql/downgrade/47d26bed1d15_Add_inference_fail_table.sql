-- Running downgrade 47d26bed1d15 -> 2d94026f5179

DROP TABLE inference_fail;

UPDATE alembic_version SET version_num='2d94026f5179' WHERE alembic_version.version_num = '47d26bed1d15';

