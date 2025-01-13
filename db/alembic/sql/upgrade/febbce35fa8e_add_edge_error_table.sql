-- Running upgrade bf91e2b5bb73 -> febbce35fa8e

CREATE TABLE edge_error (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    edge_seq INTEGER, 
    model_seq INTEGER, 
    error_datetime DATETIME NOT NULL, 
    error_type VARCHAR(1024) NOT NULL, 
    error_message VARCHAR(1024) NOT NULL, 
    file_path VARCHAR(1024), 
    created_at DATETIME, 
    PRIMARY KEY (seq), 
    FOREIGN KEY(edge_seq) REFERENCES edge (seq) ON DELETE CASCADE, 
    FOREIGN KEY(model_seq) REFERENCES model (seq) ON DELETE CASCADE
);

UPDATE alembic_version SET version_num='febbce35fa8e' WHERE alembic_version.version_num = 'bf91e2b5bb73';

