-- Running downgrade a30f7e6a9134 -> 8897db527e72

ALTER TABLE inference_fail DROP COLUMN model_version;

ALTER TABLE inference_fail DROP COLUMN input_file;

ALTER TABLE inference MODIFY decision_result VARCHAR(32) NOT NULL;

ALTER TABLE inference DROP COLUMN input_file;

UPDATE alembic_version SET version_num='8897db527e72' WHERE alembic_version.version_num = 'a30f7e6a9134';

