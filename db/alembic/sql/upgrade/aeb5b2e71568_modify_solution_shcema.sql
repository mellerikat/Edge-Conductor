-- Running upgrade c0198c6bb289 -> aeb5b2e71568

ALTER TABLE daily_summary ALTER COLUMN solution_version SET DEFAULT '0';

ALTER TABLE solution ADD COLUMN creator VARCHAR(32);

ALTER TABLE solution ADD COLUMN updator VARCHAR(32);

ALTER TABLE solution ADD UNIQUE (solution_version_id);

ALTER TABLE solution DROP COLUMN icon_path;

UPDATE alembic_version SET version_num='aeb5b2e71568' WHERE alembic_version.version_num = 'c0198c6bb289';

