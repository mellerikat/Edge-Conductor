-- Running downgrade 0e62f794f137 -> 81a8443d108a

CREATE TABLE edge_docker (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    registry VARCHAR(256) NOT NULL, 
    name VARCHAR(256) NOT NULL, 
    tag VARCHAR(128) NOT NULL, 
    repo_digest VARCHAR(71), 
    architecture VARCHAR(16), 
    created_at DATETIME, 
    PRIMARY KEY (seq)
)DEFAULT CHARSET=utf8mb4 ENGINE=InnoDB COLLATE utf8mb4_0900_ai_ci;

CREATE TABLE edge_update (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    creator VARCHAR(30), 
    docker_seq INTEGER, 
    edge_seq INTEGER, 
    status VARCHAR(16) DEFAULT 'updating', 
    created_at DATETIME, 
    completed_at DATETIME, 
    PRIMARY KEY (seq), 
    CONSTRAINT edge_update_ibfk_1 FOREIGN KEY(docker_seq) REFERENCES edge_docker (seq) ON DELETE CASCADE, 
    CONSTRAINT edge_update_ibfk_2 FOREIGN KEY(edge_seq) REFERENCES edge (seq) ON DELETE CASCADE
)DEFAULT CHARSET=utf8mb4 ENGINE=InnoDB COLLATE utf8mb4_0900_ai_ci;

UPDATE alembic_version SET version_num='81a8443d108a' WHERE alembic_version.version_num = '0e62f794f137';

