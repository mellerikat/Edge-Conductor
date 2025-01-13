CREATE TABLE alembic_version (
    version_num VARCHAR(32) NOT NULL, 
    CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num)
);

-- Running upgrade  -> 7882c6423672

CREATE TABLE daily_summary (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    reported_at DATETIME, 
    created_at DATETIME, 
    summary_date DATETIME NOT NULL, 
    workspace VARCHAR(128) NOT NULL, 
    edge_conductor_name VARCHAR(128) NOT NULL, 
    edge_id VARCHAR(32) NOT NULL, 
    edge_name VARCHAR(128) NOT NULL, 
    stream_id VARCHAR(128) NOT NULL, 
    stream_name VARCHAR(128) NOT NULL, 
    model_version VARCHAR(32), 
    solution_id VARCHAR(128) NOT NULL, 
    solution_name VARCHAR(128) NOT NULL, 
    instance_id VARCHAR(128) NOT NULL, 
    instance_name VARCHAR(128) NOT NULL, 
    inference_count INTEGER NOT NULL DEFAULT '0', 
    inference_volume INTEGER NOT NULL DEFAULT '0', 
    train_time INTEGER NOT NULL DEFAULT '0', 
    total_train_time INTEGER NOT NULL DEFAULT '0', 
    activation INTEGER NOT NULL DEFAULT '0', 
    PRIMARY KEY (seq)
);

CREATE TABLE dataset (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    name VARCHAR(128) NOT NULL, 
    `desc` VARCHAR(256), 
    data_source VARCHAR(32) NOT NULL, 
    size INTEGER, 
    is_completed BOOL, 
    created_at DATETIME, 
    creator VARCHAR(32), 
    updated_at DATETIME, 
    updator VARCHAR(32), 
    labels JSON, 
    solution_id VARCHAR(128) NOT NULL, 
    PRIMARY KEY (seq), 
    UNIQUE (name)
);

CREATE TABLE edge_docker (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    registry VARCHAR(256) NOT NULL, 
    name VARCHAR(256) NOT NULL, 
    tag VARCHAR(128) NOT NULL, 
    repo_digest VARCHAR(71), 
    architecture VARCHAR(16), 
    created_at DATETIME, 
    PRIMARY KEY (seq)
);

CREATE TABLE solution (
    instance_id VARCHAR(128) NOT NULL, 
    instance_name VARCHAR(128) NOT NULL, 
    instance_desc JSON, 
    instance_type VARCHAR(64), 
    icon_path VARCHAR(1024), 
    model_path VARCHAR(1024), 
    metadata_version FLOAT, 
    meta_data JSON, 
    inference_docker VARCHAR(1024), 
    inference_result_datatype VARCHAR(32), 
    train_datatype VARCHAR(32), 
    labeling_column_name VARCHAR(32) DEFAULT 'label', 
    support_labeling BOOL, 
    solution_id VARCHAR(128), 
    solution_name VARCHAR(128) NOT NULL, 
    PRIMARY KEY (instance_id), 
    UNIQUE (instance_id), 
    UNIQUE (instance_name)
);

CREATE TABLE user (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    user_id VARCHAR(128), 
    user_name VARCHAR(150), 
    user_password VARCHAR(128), 
    e_mail VARCHAR(256), 
    company VARCHAR(256), 
    department VARCHAR(256), 
    inactive VARCHAR(9), 
    creator VARCHAR(64), 
    created_at DATETIME, 
    updator VARCHAR(64), 
    updated_at DATETIME, 
    user_type VARCHAR(8) DEFAULT 'User', 
    password_updated_at DATETIME, 
    login_fail_count INTEGER DEFAULT '0', 
    last_login DATETIME, 
    PRIMARY KEY (seq)
);

CREATE TABLE version (
    version VARCHAR(32) NOT NULL, 
    PRIMARY KEY (version)
);

CREATE TABLE dataset_tag (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    dataset_seq INTEGER, 
    `key` VARCHAR(32) NOT NULL, 
    value VARCHAR(128) NOT NULL, 
    PRIMARY KEY (seq), 
    FOREIGN KEY(dataset_seq) REFERENCES dataset (seq) ON DELETE CASCADE
);

CREATE TABLE stream (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    name VARCHAR(128) NOT NULL, 
    instance_id VARCHAR(128), 
    confidence_score FLOAT NOT NULL, 
    creator VARCHAR(32), 
    created_at DATETIME, 
    stream_status VARCHAR(32) DEFAULT 'ready_to_train', 
    dataset_uri VARCHAR(1024), 
    stream_id VARCHAR(128) NOT NULL, 
    stream_pipeline JSON, 
    `desc` VARCHAR(256), 
    PRIMARY KEY (seq), 
    FOREIGN KEY(instance_id) REFERENCES solution (instance_id) ON DELETE CASCADE, 
    UNIQUE (name)
);

CREATE TABLE model (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    creator VARCHAR(32), 
    stream_seq INTEGER, 
    instance_id VARCHAR(128), 
    model_version VARCHAR(32), 
    model_status VARCHAR(16) DEFAULT 'training', 
    model_path VARCHAR(512), 
    artifacts_path VARCHAR(512), 
    pipeline_id VARCHAR(128), 
    created_at DATETIME, 
    started_at DATETIME, 
    complete_at DATETIME, 
    labels JSON, 
    PRIMARY KEY (seq), 
    FOREIGN KEY(instance_id) REFERENCES solution (instance_id) ON DELETE CASCADE, 
    FOREIGN KEY(stream_seq) REFERENCES stream (seq) ON DELETE CASCADE, 
    UNIQUE (stream_seq, model_version)
);

CREATE TABLE stream_tag (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    `key` VARCHAR(32) NOT NULL, 
    value VARCHAR(128) NOT NULL, 
    stream_seq INTEGER, 
    PRIMARY KEY (seq), 
    FOREIGN KEY(stream_seq) REFERENCES stream (seq) ON DELETE CASCADE
);

CREATE TABLE dataset_files (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    dataset_seq INTEGER, 
    model_seq INTEGER, 
    import_id VARCHAR(20) NOT NULL, 
    original_cls VARCHAR(32) NOT NULL, 
    probabilities VARCHAR(1024), 
    current_cls VARCHAR(32), 
    label_updated BOOL NOT NULL, 
    file_size INTEGER, 
    `lines` INTEGER DEFAULT '0', 
    created_at DATETIME, 
    updated_at DATETIME, 
    edge_id VARCHAR(32), 
    note VARCHAR(128), 
    score FLOAT, 
    PRIMARY KEY (seq), 
    FOREIGN KEY(dataset_seq) REFERENCES dataset (seq) ON DELETE CASCADE, 
    FOREIGN KEY(model_seq) REFERENCES model (seq) ON DELETE CASCADE
);

CREATE TABLE edge (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    model_seq INTEGER, 
    deployed_at DATETIME, 
    edge_id VARCHAR(32) NOT NULL, 
    security_key VARCHAR(128) NOT NULL, 
    edge_state VARCHAR(16) NOT NULL, 
    edge_status VARCHAR(16) DEFAULT 'abnormal', 
    edge_name VARCHAR(128), 
    edge_desc VARCHAR(256), 
    edge_location VARCHAR(256), 
    created_at DATETIME, 
    creator VARCHAR(32), 
    updated_at DATETIME, 
    updator VARCHAR(32), 
    websocket_status VARCHAR(16) DEFAULT 'disconnected', 
    device_os VARCHAR(128), 
    device_cpu VARCHAR(128), 
    device_gpu VARCHAR(128), 
    device_mac VARCHAR(128), 
    device_up_at DATETIME, 
    app_up_at DATETIME, 
    app_installed_at DATETIME, 
    app_version VARCHAR(128), 
    initial_ip VARCHAR(16), 
    inference_status VARCHAR(16), 
    PRIMARY KEY (seq), 
    FOREIGN KEY(model_seq) REFERENCES model (seq) ON DELETE CASCADE, 
    UNIQUE (edge_id)
);

CREATE TABLE model_dataset (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    model_seq INTEGER, 
    dataset_seq INTEGER, 
    PRIMARY KEY (seq), 
    FOREIGN KEY(dataset_seq) REFERENCES dataset (seq) ON DELETE CASCADE, 
    FOREIGN KEY(model_seq) REFERENCES model (seq) ON DELETE CASCADE
);

CREATE TABLE dataset_files_data (
    dataset_files_seq INTEGER NOT NULL, 
    idx INTEGER NOT NULL, 
    data JSON NOT NULL, 
    PRIMARY KEY (dataset_files_seq, idx), 
    FOREIGN KEY(dataset_files_seq) REFERENCES dataset_files (seq)
);

CREATE TABLE dataset_files_file (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    dataset_files_seq INTEGER NOT NULL, 
    file_path VARCHAR(1024) NOT NULL, 
    PRIMARY KEY (seq), 
    FOREIGN KEY(dataset_files_seq) REFERENCES dataset_files (seq)
);

CREATE TABLE edge_tag (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    `key` VARCHAR(32) NOT NULL, 
    value VARCHAR(128) NOT NULL, 
    edge_seq INTEGER, 
    PRIMARY KEY (seq), 
    FOREIGN KEY(edge_seq) REFERENCES edge (seq) ON DELETE CASCADE
);

CREATE TABLE edge_update (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    creator VARCHAR(32), 
    docker_seq INTEGER, 
    edge_seq INTEGER, 
    status VARCHAR(16) DEFAULT 'updating', 
    created_at DATETIME, 
    completed_at DATETIME, 
    PRIMARY KEY (seq), 
    FOREIGN KEY(docker_seq) REFERENCES edge_docker (seq) ON DELETE CASCADE, 
    FOREIGN KEY(edge_seq) REFERENCES edge (seq) ON DELETE CASCADE
);

CREATE TABLE inference (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    edge_seq INTEGER, 
    model_seq INTEGER, 
    edge_id VARCHAR(32) NOT NULL, 
    stream_name VARCHAR(128) NOT NULL, 
    model_version VARCHAR(32) NOT NULL, 
    note VARCHAR(128), 
    decision_result VARCHAR(32) NOT NULL, 
    score FLOAT, 
    probabilities VARCHAR(1024), 
    inference_datetime DATETIME NOT NULL, 
    created_at DATETIME, 
    size INTEGER NOT NULL DEFAULT '0', 
    `lines` INTEGER DEFAULT '0', 
    PRIMARY KEY (seq), 
    FOREIGN KEY(edge_seq) REFERENCES edge (seq) ON DELETE CASCADE, 
    FOREIGN KEY(model_seq) REFERENCES model (seq) ON DELETE CASCADE
);

CREATE TABLE model_deployment (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    creator VARCHAR(32), 
    stream_seq INTEGER, 
    model_seq INTEGER, 
    edge_seq INTEGER, 
    deployment_status VARCHAR(32) DEFAULT 'deploying', 
    created_at DATETIME, 
    complete_at DATETIME, 
    PRIMARY KEY (seq), 
    FOREIGN KEY(edge_seq) REFERENCES edge (seq) ON DELETE CASCADE, 
    FOREIGN KEY(model_seq) REFERENCES model (seq) ON DELETE CASCADE, 
    FOREIGN KEY(stream_seq) REFERENCES stream (seq) ON DELETE CASCADE
);

CREATE TABLE inference_data (
    inference_seq INTEGER NOT NULL, 
    idx INTEGER NOT NULL, 
    data JSON, 
    PRIMARY KEY (inference_seq, idx), 
    FOREIGN KEY(inference_seq) REFERENCES inference (seq)
);

CREATE TABLE inference_file (
    seq INTEGER NOT NULL AUTO_INCREMENT, 
    inference_seq INTEGER, 
    file_path VARCHAR(1024) NOT NULL, 
    PRIMARY KEY (seq), 
    FOREIGN KEY(inference_seq) REFERENCES inference (seq)
);

INSERT INTO alembic_version (version_num) VALUES ('7882c6423672');

