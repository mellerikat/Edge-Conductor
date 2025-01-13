-- Running upgrade 8897db527e72 -> a30f7e6a9134

ALTER TABLE inference ADD COLUMN input_file VARCHAR(128);

ALTER TABLE inference MODIFY decision_result VARCHAR(32) NULL;

ALTER TABLE inference_fail ADD COLUMN input_file VARCHAR(128);

ALTER TABLE inference_fail ADD COLUMN model_version VARCHAR(32) NOT NULL;

UPDATE alembic_version SET version_num='a30f7e6a9134' WHERE alembic_version.version_num = '8897db527e72';

