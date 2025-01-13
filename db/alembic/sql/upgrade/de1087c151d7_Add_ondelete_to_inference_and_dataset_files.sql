-- Running upgrade 0e62f794f137 -> de1087c151d7

ALTER TABLE dataset_files_data DROP FOREIGN KEY dataset_files_data_ibfk_1;

ALTER TABLE dataset_files_data ADD FOREIGN KEY(dataset_files_seq) REFERENCES dataset_files (seq) ON DELETE CASCADE;

ALTER TABLE dataset_files_file DROP FOREIGN KEY dataset_files_file_ibfk_1;

ALTER TABLE dataset_files_file ADD FOREIGN KEY(dataset_files_seq) REFERENCES dataset_files (seq) ON DELETE CASCADE;

ALTER TABLE inference_data DROP FOREIGN KEY inference_data_ibfk_1;

ALTER TABLE inference_data ADD FOREIGN KEY(inference_seq) REFERENCES inference (seq) ON DELETE CASCADE;

ALTER TABLE inference_file DROP FOREIGN KEY inference_file_ibfk_1;

ALTER TABLE inference_file ADD FOREIGN KEY(inference_seq) REFERENCES inference (seq) ON DELETE CASCADE;

UPDATE alembic_version SET version_num='de1087c151d7' WHERE alembic_version.version_num = '0e62f794f137';

