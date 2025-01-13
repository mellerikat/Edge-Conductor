-- Running downgrade 5f7a73d5f192 -> 7d5eb23dea5c

ALTER TABLE inference MODIFY stream_name VARCHAR(128) NOT NULL;

ALTER TABLE inference MODIFY edge_id VARCHAR(32) NOT NULL;

ALTER TABLE dataset_files MODIFY edge_id VARCHAR(32) NULL;

ALTER TABLE daily_summary MODIFY solution_name VARCHAR(128) NOT NULL;

ALTER TABLE daily_summary MODIFY stream_name VARCHAR(128) NOT NULL;

ALTER TABLE daily_summary MODIFY edge_name VARCHAR(128) NOT NULL;

ALTER TABLE daily_summary MODIFY edge_id VARCHAR(32) NOT NULL;

UPDATE alembic_version SET version_num='7d5eb23dea5c' WHERE alembic_version.version_num = '5f7a73d5f192';

