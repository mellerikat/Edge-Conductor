-- Running downgrade 9c05fd19a16c -> fe202fa5a4bd

ALTER TABLE edge MODIFY edge_id VARCHAR(32) NOT NULL;

ALTER TABLE edge DROP COLUMN note;

UPDATE alembic_version SET version_num='fe202fa5a4bd' WHERE alembic_version.version_num = '9c05fd19a16c';

