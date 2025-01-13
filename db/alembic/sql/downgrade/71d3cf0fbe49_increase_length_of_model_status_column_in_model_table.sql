-- Running downgrade 71d3cf0fbe49 -> 9342cc2a6fbb

ALTER TABLE model MODIFY model_status VARCHAR(16) NULL DEFAULT 'training';

UPDATE alembic_version SET version_num='9342cc2a6fbb' WHERE alembic_version.version_num = '71d3cf0fbe49';

