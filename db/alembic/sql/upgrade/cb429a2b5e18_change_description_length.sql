-- Running upgrade 9ca6cf582382 -> cb429a2b5e18

ALTER TABLE dataset MODIFY `desc` VARCHAR(250) NULL;

ALTER TABLE stream MODIFY `desc` VARCHAR(250) NULL;

UPDATE alembic_version SET version_num='cb429a2b5e18' WHERE alembic_version.version_num = '9ca6cf582382';

