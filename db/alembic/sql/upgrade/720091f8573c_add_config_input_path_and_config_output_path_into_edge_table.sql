-- Running upgrade 7882c6423672 -> 720091f8573c

ALTER TABLE edge ADD COLUMN config_input_path VARCHAR(256);

ALTER TABLE edge ADD COLUMN config_output_path VARCHAR(256);

UPDATE alembic_version SET version_num='720091f8573c' WHERE alembic_version.version_num = '7882c6423672';

