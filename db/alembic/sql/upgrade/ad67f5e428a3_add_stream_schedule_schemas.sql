-- Running upgrade febbce35fa8e -> ad67f5e428a3

CREATE TABLE stream_schedule (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    stream_seq INTEGER, 
    dataset_seq INTEGER, 
    cron_expression VARCHAR(64), 
    timezone VARCHAR(64), 
    is_activate BOOL, 
    created_at DATETIME, 
    creator VARCHAR(32), 
    updated_at DATETIME, 
    updator VARCHAR(32), 
    PRIMARY KEY (seq), 
    FOREIGN KEY(dataset_seq) REFERENCES dataset (seq) ON DELETE CASCADE, 
    FOREIGN KEY(stream_seq) REFERENCES stream (seq) ON DELETE CASCADE, 
    UNIQUE (stream_seq)
);

CREATE TABLE stream_schedule_edge (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    schedule_seq INTEGER, 
    edge_seq INTEGER, 
    PRIMARY KEY (seq), 
    FOREIGN KEY(edge_seq) REFERENCES edge (seq) ON DELETE CASCADE, 
    FOREIGN KEY(schedule_seq) REFERENCES stream_schedule (seq) ON DELETE CASCADE
);

UPDATE alembic_version SET version_num='ad67f5e428a3' WHERE alembic_version.version_num = 'febbce35fa8e';

