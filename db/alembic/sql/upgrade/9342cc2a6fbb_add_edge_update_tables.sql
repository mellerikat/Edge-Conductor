-- Running upgrade aeb5b2e71568 -> 9342cc2a6fbb

CREATE TABLE edge_update_version (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    software VARCHAR(32), 
    version VARCHAR(32) NOT NULL, 
    refreshed_at DATETIME, 
    updated_at DATETIME, 
    status VARCHAR(32), 
    PRIMARY KEY (seq), 
    UNIQUE (version)
);

CREATE TABLE edge_update_info (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    version_seq INTEGER, 
    software VARCHAR(1024) NOT NULL, 
    platform VARCHAR(1024) NOT NULL, 
    manifest VARCHAR(1024), 
    release_note VARCHAR(1024), 
    manual VARCHAR(1024), 
    created_at DATETIME, 
    updated_at DATETIME, 
    manifest_file BLOB, 
    PRIMARY KEY (seq), 
    FOREIGN KEY(version_seq) REFERENCES edge_update_version (seq) ON DELETE CASCADE
);

CREATE TABLE edge_update_docker (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    info_seq INTEGER, 
    module VARCHAR(1024) NOT NULL, 
    ecr VARCHAR(1024), 
    private_registry VARCHAR(1024), 
    PRIMARY KEY (seq), 
    FOREIGN KEY(info_seq) REFERENCES edge_update_info (seq) ON DELETE CASCADE
);

CREATE TABLE edge_update_history (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    version_seq INTEGER, 
    edge_seq INTEGER, 
    creator VARCHAR(32), 
    created_at DATETIME, 
    updated_at DATETIME, 
    completed_at DATETIME, 
    status VARCHAR(32), 
    PRIMARY KEY (seq), 
    FOREIGN KEY(edge_seq) REFERENCES edge (seq), 
    FOREIGN KEY(version_seq) REFERENCES edge_update_version (seq)
);

UPDATE alembic_version SET version_num='9342cc2a6fbb' WHERE alembic_version.version_num = 'aeb5b2e71568';

