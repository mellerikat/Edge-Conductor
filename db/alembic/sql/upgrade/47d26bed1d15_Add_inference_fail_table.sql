-- Running upgrade 2d94026f5179 -> 47d26bed1d15

CREATE TABLE inference_fail (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    edge_seq INTEGER, 
    model_seq INTEGER, 
    fail_datetime DATETIME NOT NULL, 
    fail_type VARCHAR(1024) NOT NULL, 
    fail_message VARCHAR(1024) NOT NULL, 
    file_path VARCHAR(1024), 
    created_at DATETIME, 
    PRIMARY KEY (seq), 
    FOREIGN KEY(edge_seq) REFERENCES edge (seq) ON DELETE CASCADE, 
    FOREIGN KEY(model_seq) REFERENCES model (seq) ON DELETE CASCADE
);

UPDATE alembic_version SET version_num='47d26bed1d15' WHERE alembic_version.version_num = '2d94026f5179';

