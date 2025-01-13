-- Running downgrade c0198c6bb289 -> 9c05fd19a16c

ALTER TABLE daily_summary RENAME COLUMN solution_version_id TO instance_id;;

ALTER TABLE model DROP FOREIGN KEY model_ibfk_1;

ALTER TABLE stream DROP FOREIGN KEY stream_ibfk_1;

DROP INDEX instance_id ON solution;

ALTER TABLE model RENAME COLUMN solution_version_id TO instance_id;;

ALTER TABLE stream RENAME COLUMN solution_version_id TO instance_id;;

ALTER TABLE solution RENAME COLUMN solution_version_id TO instance_id;;

ALTER TABLE solution ADD UNIQUE (instance_id);

ALTER TABLE model ADD FOREIGN KEY(instance_id) REFERENCES solution (instance_id) ON DELETE CASCADE;

ALTER TABLE stream ADD FOREIGN KEY(instance_id) REFERENCES solution (instance_id) ON DELETE CASCADE;

ALTER TABLE stream_schedule DROP COLUMN train_resource_name;

ALTER TABLE solution ADD COLUMN instance_name VARCHAR(128) NOT NULL;

CREATE INDEX instance_name ON solution (instance_name);

ALTER TABLE daily_summary ADD COLUMN instance_name VARCHAR(128) NOT NULL;

ALTER TABLE daily_summary DROP COLUMN solution_version;

UPDATE alembic_version SET version_num='9c05fd19a16c' WHERE alembic_version.version_num = 'c0198c6bb289';

