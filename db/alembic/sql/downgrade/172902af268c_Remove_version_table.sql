-- Running downgrade 172902af268c -> 93b8136d4f54

CREATE TABLE version (
    version VARCHAR(32) NOT NULL, 
    PRIMARY KEY (version)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_0900_ai_ci;

UPDATE alembic_version SET version_num='93b8136d4f54' WHERE alembic_version.version_num = '172902af268c';

