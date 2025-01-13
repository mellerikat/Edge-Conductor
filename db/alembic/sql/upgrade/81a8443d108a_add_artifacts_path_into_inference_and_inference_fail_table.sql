-- Running upgrade a30f7e6a9134 -> 81a8443d108a

ALTER TABLE inference ADD COLUMN artifacts_path VARCHAR(1024);

ALTER TABLE inference_fail CHANGE file_path artifacts_path VARCHAR(1024) NULL;

UPDATE alembic_version SET version_num='81a8443d108a' WHERE alembic_version.version_num = 'a30f7e6a9134';

