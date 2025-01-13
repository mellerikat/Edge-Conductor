-- Running upgrade 18210aedaa1c -> ac600f662cc5

ALTER TABLE solution ADD COLUMN solution_version INTEGER;

UPDATE alembic_version SET version_num='ac600f662cc5' WHERE alembic_version.version_num = '18210aedaa1c';

