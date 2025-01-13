-- Running downgrade 9342cc2a6fbb -> aeb5b2e71568

DROP TABLE edge_update_history;

DROP TABLE edge_update_docker;

DROP TABLE edge_update_info;

DROP TABLE edge_update_version;

UPDATE alembic_version SET version_num='aeb5b2e71568' WHERE alembic_version.version_num = '9342cc2a6fbb';

