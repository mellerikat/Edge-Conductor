-- Running downgrade 81a8443d108a -> a30f7e6a9134

ALTER TABLE inference_fail CHANGE artifacts_path file_path VARCHAR(1024) NULL;

ALTER TABLE inference DROP COLUMN artifacts_path;

UPDATE alembic_version SET version_num='a30f7e6a9134' WHERE alembic_version.version_num = '81a8443d108a';

