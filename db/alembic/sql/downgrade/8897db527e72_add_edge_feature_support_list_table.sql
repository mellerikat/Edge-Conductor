-- Running downgrade 8897db527e72 -> cb429a2b5e18

DROP TABLE edge_feature_support;

UPDATE alembic_version SET version_num='cb429a2b5e18' WHERE alembic_version.version_num = '8897db527e72';

