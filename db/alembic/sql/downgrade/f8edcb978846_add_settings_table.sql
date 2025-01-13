-- Running downgrade f8edcb978846 -> 71d3cf0fbe49

DROP TABLE setting;

ALTER TABLE notification DROP COLUMN level;

ALTER TABLE notification DROP COLUMN sub_category;

UPDATE alembic_version SET version_num='71d3cf0fbe49' WHERE alembic_version.version_num = 'f8edcb978846';

