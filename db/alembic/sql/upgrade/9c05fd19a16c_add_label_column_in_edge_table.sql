-- Running upgrade fe202fa5a4bd -> 9c05fd19a16c

ALTER TABLE edge ADD COLUMN note VARCHAR(64);

ALTER TABLE edge MODIFY edge_id VARCHAR(64) NOT NULL;

UPDATE alembic_version SET version_num='9c05fd19a16c' WHERE alembic_version.version_num = 'fe202fa5a4bd';

