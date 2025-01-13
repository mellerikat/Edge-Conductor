-- Running upgrade 71d3cf0fbe49 -> f8edcb978846

CREATE TABLE setting (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    webhook_url VARCHAR(256), 
    webhook_toggle JSON NOT NULL, 
    creator VARCHAR(32), 
    created_at DATETIME, 
    updator VARCHAR(32), 
    updated_at DATETIME, 
    PRIMARY KEY (seq)
);

ALTER TABLE notification ADD COLUMN sub_category VARCHAR(32);

ALTER TABLE notification ADD COLUMN level VARCHAR(32);

UPDATE alembic_version SET version_num='f8edcb978846' WHERE alembic_version.version_num = '71d3cf0fbe49';

