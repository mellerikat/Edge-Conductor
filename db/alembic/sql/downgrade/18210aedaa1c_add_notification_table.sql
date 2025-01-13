-- Running downgrade 18210aedaa1c -> 47d26bed1d15

DROP TABLE user_notification;

DROP TABLE notification;

UPDATE alembic_version SET version_num='47d26bed1d15' WHERE alembic_version.version_num = '18210aedaa1c';

