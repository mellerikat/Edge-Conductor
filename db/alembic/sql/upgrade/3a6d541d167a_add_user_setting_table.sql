-- Running upgrade aaedc88aaf65 -> 3a6d541d167a

CREATE TABLE user_setting (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    user_seq INTEGER, 
    notification_toggle JSON NOT NULL, 
    PRIMARY KEY (seq), 
    FOREIGN KEY(user_seq) REFERENCES user (seq) ON DELETE CASCADE
);

UPDATE alembic_version SET version_num='3a6d541d167a' WHERE alembic_version.version_num = 'aaedc88aaf65';

