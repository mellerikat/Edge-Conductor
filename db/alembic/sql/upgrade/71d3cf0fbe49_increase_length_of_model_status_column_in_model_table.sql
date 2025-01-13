-- Running upgrade 9342cc2a6fbb -> 71d3cf0fbe49

ALTER TABLE model MODIFY model_status VARCHAR(32) NULL DEFAULT 'training';

UPDATE alembic_version SET version_num='71d3cf0fbe49' WHERE alembic_version.version_num = '9342cc2a6fbb';

