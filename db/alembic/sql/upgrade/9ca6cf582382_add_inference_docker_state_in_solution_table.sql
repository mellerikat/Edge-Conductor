-- Running upgrade 5f7a73d5f192 -> 9ca6cf582382

ALTER TABLE solution ADD COLUMN inference_docker_state VARCHAR(16) NOT NULL DEFAULT 'created';

UPDATE solution SET inference_docker_state = 'ready';

UPDATE alembic_version SET version_num='9ca6cf582382' WHERE alembic_version.version_num = '5f7a73d5f192';

