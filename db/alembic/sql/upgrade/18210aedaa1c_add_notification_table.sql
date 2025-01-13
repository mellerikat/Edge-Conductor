-- Running upgrade 47d26bed1d15 -> 18210aedaa1c

CREATE TABLE notification (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    title VARCHAR(1024) NOT NULL, 
    category VARCHAR(32), 
    created_at DATETIME, 
    target JSON NOT NULL, 
    PRIMARY KEY (seq)
);

CREATE TABLE user_notification (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    user_seq INTEGER, 
    notification_seq INTEGER, 
    is_read VARCHAR(1) DEFAULT 'N', 
    is_deleted VARCHAR(1) DEFAULT 'N', 
    PRIMARY KEY (seq), 
    FOREIGN KEY(notification_seq) REFERENCES notification (seq) ON DELETE CASCADE, 
    FOREIGN KEY(user_seq) REFERENCES user (seq) ON DELETE CASCADE
);

UPDATE alembic_version SET version_num='18210aedaa1c' WHERE alembic_version.version_num = '47d26bed1d15';

