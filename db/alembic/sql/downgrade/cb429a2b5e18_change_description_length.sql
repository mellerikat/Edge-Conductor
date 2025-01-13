-- Running downgrade cb429a2b5e18 -> 9ca6cf582382

ALTER TABLE stream MODIFY `desc` VARCHAR(256) NULL;

ALTER TABLE dataset MODIFY `desc` VARCHAR(256) NULL;

UPDATE alembic_version SET version_num='9ca6cf582382' WHERE alembic_version.version_num = 'cb429a2b5e18';

