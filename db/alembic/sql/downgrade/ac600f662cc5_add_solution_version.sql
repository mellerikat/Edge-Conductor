-- Running downgrade ac600f662cc5 -> 18210aedaa1c

ALTER TABLE solution DROP COLUMN solution_version;

UPDATE alembic_version SET version_num='18210aedaa1c' WHERE alembic_version.version_num = 'ac600f662cc5';

