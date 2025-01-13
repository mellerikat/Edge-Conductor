-- Running downgrade 9ca6cf582382 -> 5f7a73d5f192

ALTER TABLE solution DROP COLUMN inference_docker_state;

UPDATE alembic_version SET version_num='5f7a73d5f192' WHERE alembic_version.version_num = '9ca6cf582382';

