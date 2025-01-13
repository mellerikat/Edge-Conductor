-- Running upgrade 81a8443d108a -> 0e62f794f137

DROP TABLE edge_update;

DROP TABLE edge_docker;

UPDATE alembic_version SET version_num='0e62f794f137' WHERE alembic_version.version_num = '81a8443d108a';

