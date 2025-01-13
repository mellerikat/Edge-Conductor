-- Running downgrade 5e574d6b2258 -> 3a6d541d167a

UPDATE alembic_version SET version_num='3a6d541d167a' WHERE alembic_version.version_num = '5e574d6b2258';

