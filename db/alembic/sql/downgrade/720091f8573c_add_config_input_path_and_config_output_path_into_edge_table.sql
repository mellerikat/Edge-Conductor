-- Running downgrade 720091f8573c -> 7882c6423672

ALTER TABLE edge DROP COLUMN config_output_path;

ALTER TABLE edge DROP COLUMN config_input_path;

UPDATE alembic_version SET version_num='7882c6423672' WHERE alembic_version.version_num = '720091f8573c';

