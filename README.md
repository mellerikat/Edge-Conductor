# Edge Conductor Kubernetes Helm Charts

Edge Conductor is a web-based service designed to provide efficient management and maintenance of deep learning inference models operating at the edge, along with integrated monitoring of inference results.

## Usage

[Helm](https://helm.sh) must be installed to use the charts. Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repository as follows:

#### Install Helm (prerequisite)

```console
sudo snap install helm --classic
```

#### Add repository

```console
helm repo add mellerikat-edge-conductor https://mellerikat.github.io/Edge-Conductor/
```

You can then run `helm search repo mellerikat-edge-conductor [ --versions ]` to see the charts.

#### Install the chart

To install the chart with the release name `edge-conductor` in the `edge-conductor`  namespace

```console
helm install edge-conductor mellerikat-edge-conductor/edge-conductor [ --version 0.2.0 ] -n edge-conductor
```

| Tip: List all releases using `helm ls [ -A | -n namepsace ]`

#### Uninstall the chart

To uninstall/delete the `edge-conductor` release in the `edge-conductor` namespace

```console
helm delete edge-conductor -n edge-conductor
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

#### Update chart repository

```console
helm repo update mellerikat-edge-conductor
```

#### Chart download

```console
helm pull mellerikat-edge-conductor/edge-conductor [ --version 0.2.0 ] [ --untar ]
```

---
## Minir Version Release Note

### 0.2.x

* Env 항목 삭제 :

   FIRST_SUPERUSER  |  FIRST_SUPERUSER_PW
   
   AIC_HOST  |  AIC_PORT  |  AIC_SUFFIX  |   AIC_WORKSPACE_NAME  |  AIC_USER  |   AIC_PSWD  |   AIC_LINK

* Env 항목 추가:

  UPDATE_CENTER_URL (MANDATORY)
  
  SQLALCHEMY_POOL_MAX_OVERFLOW (OPTIONAL)  |   SQLALCHEMY_POOL_SIZE (OPTIONAL)

---

## Parameters

The following is the values file in edge-conductor chart version 0.2.0

```bash
$ helm show values edge-conductor-0.2.0.tgz | tree values.yaml

# Default values for edge-conductor.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

global:
  serviceAccountName: "edge-conductor"
  secretName: "secret-edgecond"
  configMapName: "config-edgecond"
  pvcName: "pvc-edgecond"
  nodeSelector:
    nodegroup: ng-an2-edgecond-mellerikat
  #backend and frontend image tag whose default is the chart appVersion.
  #tag: "2.2.1"


backend:
  enabled: true
  replicaCount: 1
  image:
    repository: "edge-conductor/backend"
    pullPolicy: IfNotPresent
    # Overrides the global.tag .
    #tag: "2.2.1"
  service:
    type: NodePort
    port: 31020
    nodePort: 31020
    internal:
      enabled: true

  celery:
    enabled: true
    replicaCount: 1
  
  flower:
    enabled: false
    replicaCount: 1
    service:
      type: NodePort
      port: 80
      nodePort: 31070


frontend:
  enabled: true
  replicaCount: 1
  image:
    repository: "edge-conductor/frontend"
    pullPolicy: IfNotPresent
    # Overrides the global.tag .
    # tag: "2.2.1"
  service:
    type: NodePort
    port: 80
    nodePort: 31010



pv:
  storageClassName: efs-sc-edgecond
  storage: 30Gi
  csi:
    volumeHandle: fs-00000000000000000


secret:
  data:
    - key: "MYSQL_USER"
      objectName: "dbusername"
    - key: "MYSQL_PSWD"
      objectName: "dbpassword"
    - key: "MYSQL_HOST"
      objectName: "dbhost"
    - key: "MYSQL_PORT"
      objectName: "dbport"
  objects:
    - objectName: "/parameter/ap-northeast-2/mellerikat/dev/rds"
      objectType: "secretsmanager"
      jmesPath:
        - path: "username"
          objectAlias: "dbusername"
        - path: "password"
          objectAlias: "dbpassword"
        - path: "host"
          objectAlias: "dbhost"
        - path: "port"
          objectAlias: "dbport"


env:
  CONTAINER_NAME: edgecond
  HOSTUID: 1175
  HOSTGID: 1175
  MYSQL_NAME: edgecond_db
  PROJECT_NAME: Mellerikat Edge Conductor
  SERVER_IP: edgecond.meerkat-dev.com
  JWT_SECRET: edgecond@lge
  LOGGING_LEVEL: INFO
  LOGGING_ROTATE: 0:00
  LOGGING_COUNT: 90
  BACKEND_CORS_ORIGINS: '["https://edgecond.meerkat-dev.com"]'
  BACKEND_ENDPOINT: https://edgecond.meerkat-dev.com
  VAULT_TOKEN: ""
  VAULT_CATOZ: ""
  VAULT_NAMESPACE: ""
  REDIS_URL: rediss://master.redis-an2-meerkat-dev-private.xxxxxx.apn2.cache.amazonaws.com:6379/0
  CELERY_REDIS_URL: rediss://master.redis-an2-meerkat-dev-private.xxxxxx.apn2.cache.amazonaws.com:6379/1?ssl_cert_reqs=required
  LDAP_HOST: ""
  WORKSPACE: edgecond.meerkat-dev
  DAILY_SUMMARY_SERVER_URL: http://0.0.0.0:46599
  WEBHOOK_TEAMS: ""
  UPDATE_CENTER_URL: ""
```

The description of the values

|values|설명|Cloud 인프라 의존 여부|EKS Cluster내 유일값 여부|예제|
|--|--|--|--|--|
|serviceAccountName|Edge Conductor 실행될 K8s Service Account Name|O|O|edge-conductor|
|secretName|SecretProviderClass 부여할 이름|X|O|secret-edgecond|
|configMapName|ConfigMap 부여할 이름|X|O|config-edgecond|
|pvcName|PersistentVolumeClaim 부여할 이름|X|O|pvc-edgecond|
|nodeSelector|Edge Conductor 실행될 Cloud에서 생성된 NodeGroup 정보|O|X|nodegroup: ng-an2-edgecond-mellerikat|
|backend: replicaCount|Deployment안에서 수행될 pod relicaset|X|X|2|
|backend: port & nodePort|backend Service 포트정보|O|O|31020, 31020|
|flower: replicaCount|Deployment안에서 수행될 pod relicaset|X|X|2|
|front: replicaCount|Deployment안에서 수행될 pod relicaset|X|X|1|
|frontend: nodePort|backend Service 포트정보|O|O|31010|
|pv: storageClassName|PersistentVolume에서 사용할 StorageClass 이름|X|X|efs-sc-edgecond|
|pv: csi: vloumeHandle|pv storageClass에서 사용할 efs id|O|O|fs-00000000000000000|
|secret: objects: objectName|AWS sceretmanager 정보|O|X|/parameter/ap-northeast-2/mellerikat/dev/rds|
|env: MYSQL_NAME|rds mysql에서 사용할 database schema|O|X|edge_conductor|
|env: SERVER_IP|Route53 정의된 edge conductor domain|O|X|edgecond.meerkat-dev.com|
|env: BACKEND_CORS_ORIGINS|Route53에 정의된 Edge Conductor Domain정보|O|X|'["https://edgecond.meerkat-dev.com"]'|
|env: BACKEND_ENDPOINT|Route53에 정의된 Edge Conductor Domain정보|O|X|https://edgecond.meerkat-dev.com|
|env: WORKSPACE|서머리서버에서 사용될 설치된 Edge Conductor고유이름|X|X|edge_conductor_meerkat_dev|
|env: DAILY_SUMMARY_SERVER_URL|서머리서버 정보|X|X|http://0.0.0.0:46599|
|env: REDIS_URL|elasticcache 정보|O|X|rediss://master.redis-an2-xxx-private.xxxxxx.apn2.cache.amazonaws.com:6379/0|
|env: CELERY_REDIS_URL|elasticcache 정보|O|X|rediss://master.redis-an2-xxx-private.xxxxxx.apn2.cache.amazonaws.com:6379/1?ssl_cert_reqs=required|
|env: LDAP_HOST|ldap 정보 (미지원인 경우 "")|X|X|*|
|env: UPDATE_CENTER_URL|Update Center URL 정보|X|X|https://xxxxxxxx.execute-api.ap-northeast-2.amazonaws.com/v1|

--- 

# Welcome to Edge Conductor !

Edge Conductor is a web-based service designed to provide efficient management and maintenance of deep learning inference models operating at the edge, along with integrated monitoring of inference results.

## Key Features

Edge Conductor enhances performance efficiency in operational environments by monitoring inference situations at the edge and managing training datasets, model training, and deployment. Here are the main features of Edge Conductor:

#### Integrated Edge Monitoring

Centralized monitoring of multiple edges performing inference tasks. It collects a wide range of information, including device information and inference performance scores, from the edges.

#### Training Data Management

To achieve more accurate inference, users can create and manage training datasets. These datasets can be generated from various data sources, such as inference data collected from edges, local PC data, and S3 data. The platform will continually add more data sources according to customer requirements. Additionally, it provides relabeling tools for users to redefine label values in training datasets when the solution supports dataset labeling.

#### Utilization of Diverse Solutions

Users can explore and select from a variety of solutions supported by Mellerikat. Through streams created by these solutions, users can request model training from AI Conductor and manage the deployment of the generated models to the edges.

#### Model Management and Deployment

Users can select training datasets and request updates to models. The performance metrics of the generated models are available for review, and updated models can be deployed to edges to improve inference accuracy.

# User Guide
- [Edges](https://mellerikat.com/user_guide/ai_operator_guide/edge_conductor/edges)
- [Dataset](https://mellerikat.com/user_guide/ai_operator_guide/edge_conductor/dataset)
- [Streams](https://mellerikat.com/user_guide/ai_operator_guide/edge_conductor/streams)
