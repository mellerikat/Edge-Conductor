-- Running upgrade 172902af268c -> fe202fa5a4bd

ALTER TABLE user ADD UNIQUE (user_id);

UPDATE alembic_version SET version_num='fe202fa5a4bd' WHERE alembic_version.version_num = '172902af268c';

