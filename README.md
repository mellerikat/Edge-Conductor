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

To install the chart with the release name `edge-conductor` in the `edge-conductor` namespace

```console
helm install edge-conductor mellerikat-edge-conductor/edge-conductor [ --version 0.2.0 ] -n edge-conductor
```

> Tip: List all releases using `helm ls [ -A | -n namepsace ]`


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
## Release Note

#### Major Version

*1.0.0*

- global 변수를 지정해서 생성했던, secret, pv, pvc 등을 template을 이용해서 자동으로 생성
- 대부분 같은 값을 사용하게 됐던 변수에 대해서는 default 값을 지정하여, 값을 입력하지 않도록 함.
- 사용자가 변경해야하는 config 값을 최소한으로만 노출
- values.yaml 에서 변경사항이 없는 부분에 대해서는 template 으로 이동하여 노출하지 않도록 함.

#### Minor Version

*0.2.x*

**Env 항목 삭제 :**
- `FIRST_SUPERUSER`, `FIRST_SUPERUSER_PW`
- `AIC_HOST`, `AIC_PORT`, `AIC_SUFFIX`, `AIC_WORKSPACE_NAME`, `AIC_USER`, `AIC_PSWD`, `AIC_LINK`

**Env 항목 추가:**
- `(mandatory) UPDATE_CENTER_URL`
- `(optional) SQLALCHEMY_POOL_MAX_OVERFLOW` | `(optional) SQLALCHEMY_POOL_SIZE`

---

## Parameters


The description of the values


#### Global parameters
| Name                            | Description                                         | Cloud 인프라 의존 값 | EKS Cluster내 유일값 | 예제                                  |
| ----                            | --------------------------------------------------- | ------------------- | ------------------- | ------------------------------------- |
| `serviceAccount.name`           | Edge Conductor 실행될 K8s Service Account Name       | O                  | O                   | `edge-conductor`                       |
| `nodeSelector.nodegroup`        | Edge Conductor 실행될 Cloud에서 생성된 NodeGroup 정보 | O                  | X                   | `nodegroup: ng-an2-edgecond-mellerikat` |

#### backend parameters
| Name                            | Description                                 | Cloud 인프라 의존 값 | EKS Cluster내 유일값 | 예제    |
| ----                            | ------------------------------------------- | ------------------- | ------------------- | ------- |
| `backend.service.nodePort`      | backend Service 포트정보                     | O                   | O                   | `31020` |
| `backend.replicaCount`          | Deployment안에서 수행될 pod relicaset        | X                   | X                   | `2`     |
| `backend.flower.replicaCount`   | flower Deployment안에서 수행될 pod relicaset | X                   | X                   | `2`     |

#### frontend parameters
| Name                            | Description                          | Cloud 인프라 의존 값 | EKS Cluster내 유일값 | 예제     |
| ----                            | ------------------------------------ | ------------------- | ------------------- | -------- |
| `frontend.service.nodePort`     | frontend Service 포트정보             | O                  | O                    | `31010` |
| `frontend.replicaCount`         | Deployment안에서 수행될 pod relicaset | X                   | X                   | `1`     |

#### common parameters
| Name                                  | Description                                      | Cloud 인프라 의존 값 | EKS Cluster내 유일값 | 예제                                                           |
| ------------------------------------- | ------------------------------------------------ | ------------------- | ------------------- | -------------------------------------------------------------- |
| `pv.storageClassName`                 | PersistentVolume에서 사용할 StorageClass 이름     | X                   | X                   | `efs-sc-edgecond`                                              |
| `pv.csi.vloumeHandle`                 | pv storageClass에서 사용할 efs id                 | O                   | O                   | `fs-00000000000000000`                                         |
| `redis.url`                           | aws에 설치된 elasticcache(redis) 주소             | O                   | O                   | `rediss://master.redis.xxxxx.apn2.cache.amazonaws.com:6379`    |
| `secret.objects.name`                 | AWS sceretmanager 정보                           | O                   | X                   | `/parameter/ap-northeast-2/mellerikat/dev/rds`                 |
| `configMap.data.BACKEND_CORS_ORIGINS` | Route53에 정의된 Edge Conductor Domain정보        | O                   | X                   | `'["https://edgecond.meerkat-dev.com"]'`                       |
| `configMap.data.BACKEND_ENDPOINT`     | Route53에 정의된 Edge Conductor Domain정보        | O                   | X                   | `https://edgecond.meerkat-dev.com`                             |
| `configMap.data.MYSQL_NAME`           | rds mysql에서 사용할 database schema              | O                   | X                   | `edge_conductor`                                               |
| `configMap.data.SERVER_IP`            | Route53 정의된 edge conductor domain             | O                   | X                    | `edgecond.meerkat-dev.com`                                    |
| `configMap.data.WORKSPACE`            | 서머리서버에서 사용될 설치된 Edge Conductor고유이름 | X                   | X                   | `edge_conductor_meerkat_dev`                                   |
| `configMap.data.LDAP_HOST`            | ldap 정보 (미지원인 경우 "")                      | X                   | X                   | `*`                                                            |
| `configMap.data.UPDATE_CENTER_URL`    | Update Center URL 정보                           | X                   | X                   | `https://xxxxxxxx.execute-api.ap-northeast-2.amazonaws.com/v1` |

--- 

The following is the values file in edge-conductor chart version 1.1.0

```bash
$ helm show values edge-conductor-1.1.0.tgz | tree values.yaml

# Default values for edge-conductor.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

## Global values are values that can be used from templetes or subchart(backend/frontend)
##
global:
  ## Set the deployed serviceAccount name
  serviceAccount:
    name: "edge-conductor"

  ## Set the nodeSelector
  nodeSelector:
    nodegroup: ng-an2-edgecond-mellerikat

  ## If not set, backend/frontend image tag will be "appVersion" in Chart.yaml.
  # tag: "2.2.1"


backend:
  ## Deploy backend
  enabled: true

  celery:
    enabled: true
    replicaCount: 1

  flower:
    enabled: false
    replicaCount: 1
    service:
      nodePort: 31070

  image:
    repository: "edge-conductor/backend"
    pullPolicy: IfNotPresent

    ## If not set, backend image tag will be .Values.global.tag.
    # tag: "2.2.1"

  replicaCount: 1

  service:
    nodePort: 31020
    internal:
      enabled: true


frontend:
  ## Deploy frontend
  enabled: true

  image:
    repository: "edge-conductor/frontend"
    pullPolicy: IfNotPresent
    
    ## If not set, backend image tag will be .Values.global.tag.
    # tag: "2.2.1"

  replicaCount: 1

  service:
    nodePort: 31010


pv:
  ## Use 'pv-{{ include "edge-conductor.fullname" . }}' by default
  nameOverride: ""
  csi:
    volumeHandle: fs-00000000000000000
  storageClassName: efs-sc-edgecond
  storage: 30Gi

  ## Use 'pvc-{{ include "edge-conductor.fullname" . }}' by default
  pvc:
    nameOverride: ""


redis:
  url: rediss://master.redis-an2-meerkat-dev-private.xxxxxx.apn2.cache.amazonaws.com:6379


secret:
  ## If you need additional secret data
  #
  data: []
  # - key: "MYSQL_USER"
  # objectName: "dbusername"

  objects:
    name: "/parameter/ap-northeast-2/mellerikat/dev/rds"

    ## If you need additional objects data
    #
    additionalObjects: []
    # - objectName: "/parameter/ap-northeast-2/mellerikat/dev/rds"
    #   objectType: "secretsmanager"
    #   jmesPath:
    #     - path: "username"
    #       objectAlias: "dbusername"

  ## Use '{{ include "edge-conductor.fullname" . }}-secretprovider' by default
  secretProvider:
    nameOverride: ""


configMap:
  ## Use config-{release-name} by default
  nameOverride: ""
  additionalConfig: {}

  data:
    BACKEND_CORS_ORIGINS: '["https://edgecond.meerkat-dev.com"]'
    BACKEND_ENDPOINT: https://edgecond.meerkat-dev.com
    MYSQL_NAME: edgecond_db
    SERVER_IP: edgecond.meerkat-dev.com
    WORKSPACE: edgecond.meerkat-dev

    ## The key below is given a default value, please modify it out if you want to change it.
    # CONTAINER_NAME: "edgecond"  # sh-script에서 사용 -> 삭제 
    # DAILY_SUMMARY_SERVER_URL: "http://0.0.0.0:46599" 
    # HOSTGID: HOSTGID  "1175"
    # HOSTUID: HOSTUID  "1175"
    # JWT_SECRET: "edgecond@lge" 
    # LDAP_HOST: ""
    # LOGGING_COUNT: "90" 
    # LOGGING_LEVEL: "INFO" 
    # LOGGING_ROTATE: "0:00" 
    # MYSQL_NAME: "edgecond_db"  # config에서 사용
    # PROJECT_NAME: "Mellerikat Edge Conductor" 
    # SQLALCHEMY_POOL_MAX_OVERFLOW: "10"
    # SQLALCHEMY_POOL_SIZE: "5"
    # UPDATE_CENTER_URL: ""
    # VAULT_CATOZ: ""
    # VAULT_NAMESPACE: ""
    # VAULT_TOKEN: ""
    # WEBHOOK_TEAMS: ""
    #

```

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
