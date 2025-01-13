-- Running upgrade cb429a2b5e18 -> 8897db527e72

CREATE TABLE edge_feature_support (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    edge_seq INTEGER, 
    edge_app_update BOOL NOT NULL, 
    PRIMARY KEY (seq), 
    FOREIGN KEY(edge_seq) REFERENCES edge (seq) ON DELETE CASCADE
);

UPDATE alembic_version SET version_num='8897db527e72' WHERE alembic_version.version_num = 'cb429a2b5e18';

