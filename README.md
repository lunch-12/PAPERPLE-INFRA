# PAPERPLE-Infra

- [Paperple](#paperple)
- [Tech Stack](#tech-stack)
- [Roles & Responsibilities](#roles--responsibilities)
- [CICD Flow](#cicd-flow)
- [Task Details](#task-details)
- [Done & To-Dos](#done--to-dos)
- [Blog Articles](#blog-articles)

## Paperple

최신 뉴스를 요약해서 제공하고 뉴스 관련 주식 정보를 제공하는 SNS 서비스 입니다. <br/>
Paperple은 `Paper + People`로 Paper를 통한 People의 연결을 의미합니다. <br/>
`Paper`는 요약된 뉴스를 기반으로 작성한 커뮤니티 글을 지칭합니다. <br/>

| 랜딩                                                                                      | 뉴스탭                                                                                    | 페이퍼탭                                                                                  | 페이퍼 등록                                                                               |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| ![image](https://github.com/user-attachments/assets/2b48f301-4cc3-4a71-a33a-62ad369a3d99) | ![image](https://github.com/user-attachments/assets/f830cf49-8c9f-4b20-8307-e66ec84ebb42) | ![image](https://github.com/user-attachments/assets/4f6e78b6-c1b9-43a3-b593-fcf82d39307a) | ![image](https://github.com/user-attachments/assets/1dfbbeee-52bd-4a87-9e07-7df694d4e754) |

## Tech Stack

| **CSP**                                                                                                        | **Infra**                                                                                                        | **Deployment**                                                                                                 | **CI/CD**                                                                                                                                                                                                     | **Image**                                                                                              |
| -------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| <img src="https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonwebservices&logoColor=white"> | <img src="https://img.shields.io/badge/Terraform-844FBA?style=for-the-badge&logo=terraform&logoColor=white"></a> | <img src="https://img.shields.io/badge/kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white"> | <img src="https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white"> <img src="https://img.shields.io/badge/ArgoCD-EF7B4D?style=for-the-badge&logo=argo&logoColor=white"> | <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=Docker&logoColor=white"> |

## Roles & Responsibilities
![image](https://user-content.gitlab-static.net/35c6c5f47b16e9a3292cfed46f4a51ac07244f32/68747470733a2f2f696d616765732e7765736572762e6e6c2f3f75726c3d68747470733a2f2f617661746172732e67697468756275736572636f6e74656e742e636f6d2f686e6e796e683f763d342532323f763d3426683d32353026773d323530266669743d636f766572266d61736b3d636972636c65266d61786167653d3764)
### Cloud Team | 한윤호 | hnnynh

[GitHub](https://github.com/hnnynh) | [Blog](https://velog.io/@hnnynh/posts) | [LinkedIn](https://www.linkedin.com/in/%EC%9C%A4%ED%98%B8-%ED%95%9C-759471291/)

1. AWS Cloud Infra 설계 및 구성
2. GitOps 기반의 Jenkins, ArgoCD 활용 CI/CD
3. EKS 배포 및 스케일링 자동화

## CICD Flow

![cicd drawio](https://github.com/user-attachments/assets/34ef8115-f241-43fe-8d4f-20255b33f1a1)

## Task Details

### Kubernetes | Deployment

<details>
  <summary>kubectl get all -A</summary>

```
NAMESPACE              NAME                                                   READY   STATUS      RESTARTS      AGE
argocd                 pod/argocd-application-controller-0                    1/1     Running     0             29d
argocd                 pod/argocd-applicationset-controller-c66b59c7b-xcs7q   1/1     Running     0             29d
argocd                 pod/argocd-dex-server-6584f99d8b-46482                 1/1     Running     2 (29d ago)   29d
argocd                 pod/argocd-notifications-controller-7577b685c4-v2d5v   1/1     Running     0             22d
argocd                 pod/argocd-redis-5ccbfd788-gqh89                       1/1     Running     0             29d
argocd                 pod/argocd-repo-server-7b6654b6f-6hcqz                 1/1     Running     0             29d
argocd                 pod/argocd-server-65965c75-tr7dl                       1/1     Running     0             29d
cert-manager           pod/cert-manager-756d54fb98-kh4zn                      1/1     Running     0             26d
cert-manager           pod/cert-manager-cainjector-7d96c69dbf-xr8t8           1/1     Running     0             26d
cert-manager           pod/cert-manager-webhook-778c78f68c-9lcmv              1/1     Running     0             26d
default                pod/backend-865fbd6d76-2r2nw                           1/1     Running     0             16h
default                pod/backend-865fbd6d76-tq9fm                           1/1     Running     0             21h
default                pod/fastapi-ai-778576d5f7-686sq                        1/1     Running     0             7d2h
default                pod/fastapi-ai-778576d5f7-z6wp6                        1/1     Running     0             21h
default                pod/nginx                                              1/1     Running     0             29d
ingress-nginx          pod/ingress-nginx-admission-create-vrq7h               0/1     Completed   0             8d
ingress-nginx          pod/ingress-nginx-admission-patch-x6hvs                0/1     Completed   0             8d
ingress-nginx          pod/ingress-nginx-controller-68949dbd99-5v26r          1/1     Running     0             8d
kube-system            pod/aws-node-9kwq9                                     2/2     Running     0             31d
kube-system            pod/aws-node-gnlvl                                     2/2     Running     0             31d
kube-system            pod/cluster-autoscaler-578dc5b9cf-crrws                1/1     Running     0             22d
kube-system            pod/coredns-5b9dfbf96-fg5xs                            1/1     Running     0             31d
kube-system            pod/coredns-5b9dfbf96-pt27f                            1/1     Running     0             31d
kube-system            pod/eks-pod-identity-agent-9l9qz                       1/1     Running     0             31d
kube-system            pod/eks-pod-identity-agent-r2frh                       1/1     Running     0             31d
kube-system            pod/kube-proxy-glp27                                   1/1     Running     0             31d
kube-system            pod/kube-proxy-prp82                                   1/1     Running     0             31d
kube-system            pod/metrics-server-fdc58cbc8-fx7qq                     1/1     Running     0             24d
kube-system            pod/metrics-server-fdc58cbc8-q6rl6                     1/1     Running     0             24d
kubernetes-dashboard   pod/dashboard-metrics-scraper-795895d745-rqb54         1/1     Running     0             23d
kubernetes-dashboard   pod/kubernetes-dashboard-6c8b589b99-5cgsl              1/1     Running     0             23d
logging                pod/elasticsearch-0                                    1/1     Running     0             30d
logging                pod/fluentd-rmj9b                                      1/1     Running     0             30d
logging                pod/fluentd-tqv6j                                      1/1     Running     0             30d
logging                pod/kibana-84b455877-nlh7m                             1/1     Running     0             29d

NAMESPACE NAME TYPE CLUSTER-IP EXTERNAL-IP PORT(S) AGE
argocd service/argocd-applicationset-controller ClusterIP 10.100.110.239 <none> 7000/TCP,8080/TCP 29d
argocd service/argocd-dex-server ClusterIP 10.100.205.209 <none> 5556/TCP,5557/TCP,5558/TCP 29d
argocd service/argocd-metrics ClusterIP 10.100.17.204 <none> 8082/TCP 29d
argocd service/argocd-notifications-controller-metrics ClusterIP 10.100.215.125 <none> 9001/TCP 29d
argocd service/argocd-redis ClusterIP 10.100.53.0 <none> 6379/TCP 29d
argocd service/argocd-repo-server ClusterIP 10.100.75.154 <none> 8081/TCP,8084/TCP 29d
argocd service/argocd-server LoadBalancer 10.100.80.115 ac0382fa479d0488a87f391ff1cca0ee-697501886.ap-northeast-2.elb.amazonaws.com 80:32564/TCP,443:31562/TCP 29d
argocd service/argocd-server-metrics ClusterIP 10.100.224.13 <none> 8083/TCP 29d
cert-manager service/cert-manager ClusterIP 10.100.246.248 <none> 9402/TCP 26d
cert-manager service/cert-manager-webhook ClusterIP 10.100.97.236 <none> 443/TCP 26d
default service/backend-svc LoadBalancer 10.100.194.255 a1225427585aa4bf8a5fdf1716eedb16-701133007.ap-northeast-2.elb.amazonaws.com 80:30555/TCP,443:32211/TCP 7d2h
default service/fastapi-ai-svc LoadBalancer 10.100.20.74 a2f3189ee47f1456c956a0503bf1d8ec-20127502.ap-northeast-2.elb.amazonaws.com 8000:31118/TCP 7d2h
default service/kubernetes ClusterIP 10.100.0.1 <none> 443/TCP 31d
ingress-nginx service/ingress-nginx-controller LoadBalancer 10.100.46.98 ac1de57345af14269961656f4cc62397-1809251496.ap-northeast-2.elb.amazonaws.com 80:32014/TCP,443:32176/TCP 8d
ingress-nginx service/ingress-nginx-controller-admission ClusterIP 10.100.145.12 <none> 443/TCP 8d
kube-system service/kube-dns ClusterIP 10.100.0.10 <none> 53/UDP,53/TCP,9153/TCP 31d
kube-system service/metrics-server ClusterIP 10.100.96.112 <none> 443/TCP 27d
kube-system service/prometheus-kube-prometheus-kubelet ClusterIP None <none> 10250/TCP,10255/TCP,4194/TCP 7d18h
kubernetes-dashboard service/dashboard-metrics-scraper ClusterIP 10.100.182.25 <none> 8000/TCP 23d
kubernetes-dashboard service/kubernetes-dashboard ClusterIP 10.100.236.9 <none> 443/TCP 23d
logging service/elasticsearch-svc ClusterIP 10.100.142.36 <none> 9200/TCP,9300/TCP 30d
logging service/kibana-svc LoadBalancer 10.100.6.183 a87974cae3c0744b6b2d8e6ef243b2d1-1233900006.ap-northeast-2.elb.amazonaws.com 80:30559/TCP,443:30574/TCP 29d

NAMESPACE NAME DESIRED CURRENT READY UP-TO-DATE AVAILABLE NODE SELECTOR AGE
kube-system daemonset.apps/aws-node 2 2 2 2 2 <none> 31d
kube-system daemonset.apps/eks-pod-identity-agent 2 2 2 2 2 <none> 31d
kube-system daemonset.apps/kube-proxy 2 2 2 2 2 <none> 31d
logging daemonset.apps/fluentd 2 2 2 2 2 <none> 30d

NAMESPACE NAME READY UP-TO-DATE AVAILABLE AGE
argocd deployment.apps/argocd-applicationset-controller 1/1 1 1 29d
argocd deployment.apps/argocd-dex-server 1/1 1 1 29d
argocd deployment.apps/argocd-notifications-controller 1/1 1 1 29d
argocd deployment.apps/argocd-redis 1/1 1 1 29d
argocd deployment.apps/argocd-repo-server 1/1 1 1 29d
argocd deployment.apps/argocd-server 1/1 1 1 29d
cert-manager deployment.apps/cert-manager 1/1 1 1 26d
cert-manager deployment.apps/cert-manager-cainjector 1/1 1 1 26d
cert-manager deployment.apps/cert-manager-webhook 1/1 1 1 26d
default deployment.apps/backend 2/2 2 2 7d2h
default deployment.apps/fastapi-ai 2/2 2 2 7d2h
ingress-nginx deployment.apps/ingress-nginx-controller 1/1 1 1 8d
kube-system deployment.apps/cluster-autoscaler 1/1 1 1 22d
kube-system deployment.apps/coredns 2/2 2 2 31d
kube-system deployment.apps/metrics-server 2/2 2 2 27d
kubernetes-dashboard deployment.apps/dashboard-metrics-scraper 1/1 1 1 23d
kubernetes-dashboard deployment.apps/kubernetes-dashboard 1/1 1 1 23d
logging deployment.apps/kibana 1/1 1 1 29d

NAMESPACE NAME DESIRED CURRENT READY AGE
argocd replicaset.apps/argocd-applicationset-controller-c66b59c7b 1 1 1 29d
argocd replicaset.apps/argocd-dex-server-6584f99d8b 1 1 1 29d
argocd replicaset.apps/argocd-notifications-controller-6f7bdc5db6 0 0 0 29d
argocd replicaset.apps/argocd-notifications-controller-7577b685c4 1 1 1 22d
argocd replicaset.apps/argocd-redis-5ccbfd788 1 1 1 29d
argocd replicaset.apps/argocd-repo-server-7b6654b6f 1 1 1 29d
argocd replicaset.apps/argocd-server-65965c75 1 1 1 29d
cert-manager replicaset.apps/cert-manager-756d54fb98 1 1 1 26d
cert-manager replicaset.apps/cert-manager-cainjector-7d96c69dbf 1 1 1 26d
cert-manager replicaset.apps/cert-manager-webhook-778c78f68c 1 1 1 26d
default replicaset.apps/backend-54b9747876 0 0 0 7d2h
default replicaset.apps/backend-57f65f5f6 0 0 0 6d20h
default replicaset.apps/backend-5d6679bcf5 0 0 0 7d2h
default replicaset.apps/backend-64bdd444ff 0 0 0 26h
default replicaset.apps/backend-7c4f47899f 0 0 0 21h
default replicaset.apps/backend-858564669 0 0 0 6d21h
default replicaset.apps/backend-85c969ff67 0 0 0 6d23h
default replicaset.apps/backend-865fbd6d76 2 2 2 21h
default replicaset.apps/backend-887d4f667 0 0 0 6d20h
default replicaset.apps/backend-fc54b6459 0 0 0 6d21h
default replicaset.apps/backend-fcb469b58 0 0 0 26h
default replicaset.apps/fastapi-ai-5bf87794fb 0 0 0 7d2h
default replicaset.apps/fastapi-ai-778576d5f7 2 2 2 7d2h
ingress-nginx replicaset.apps/ingress-nginx-controller-68949dbd99 1 1 1 8d
kube-system replicaset.apps/cluster-autoscaler-578dc5b9cf 1 1 1 22d
kube-system replicaset.apps/cluster-autoscaler-67d484786c 0 0 0 22d
kube-system replicaset.apps/cluster-autoscaler-878868868 0 0 0 22d
kube-system replicaset.apps/cluster-autoscaler-cf65f5dc 0 0 0 22d
kube-system replicaset.apps/coredns-5b9dfbf96 2 2 2 31d
kube-system replicaset.apps/metrics-server-7ffbc6d68 0 0 0 27d
kube-system replicaset.apps/metrics-server-fdc58cbc8 2 2 2 24d
kubernetes-dashboard replicaset.apps/dashboard-metrics-scraper-795895d745 1 1 1 23d
kubernetes-dashboard replicaset.apps/kubernetes-dashboard-6c8b589b99 1 1 1 23d
logging replicaset.apps/kibana-84b455877 1 1 1 29d

NAMESPACE NAME READY AGE
argocd statefulset.apps/argocd-application-controller 1/1 29d
logging statefulset.apps/elasticsearch 1/1 30d

NAMESPACE NAME REFERENCE TARGETS MINPODS MAXPODS REPLICAS AGE
default horizontalpodautoscaler.autoscaling/backend Deployment/backend cpu: 1%/50% 2 4 2 7d2h
default horizontalpodautoscaler.autoscaling/fastapi-ai Deployment/fastapi-ai cpu: 1%/50% 2 4 2 7d2h

NAMESPACE NAME STATUS COMPLETIONS DURATION AGE
ingress-nginx job.batch/ingress-nginx-admission-create Complete 1/1 7s 8d
ingress-nginx job.batch/ingress-nginx-admission-patch Complete 1/1 8s 8d
```

</details>

#### EKS

- 컨트롤플레인 1개 = 리소스 사용 최소화
- 노드 그룹 구성 | 노드 2개 - 최대 4개 = 최소한의 가용성 보장
- 서비스 배포

- namespace: default
- 백엔드 svc LoadBalancer
- 인공지능 svc 파드 / AI 파드 통신

- 스케일링 자동화 - 안정성
- metrics-server 설치
- 수평적 확장: 백엔드, 인공지능 각각 HPA 설정
- 수직적 확장: cluster-autoscaler 설정
- nginx ingress controller

- 백엔드 Service Ingress로 노출
- cert-manager로 TLS 인증서 발급 자동화
- 쿠키, CORS 설정으로 OAuth 로그인 프론트엔드와 연동 성공

- EFK 노드 로그 수집
- namespace: logging
- ElasticSearch
- Fluentd (Daemonset)
- Kibana - LoadBalancer 서비스로 AWS에서 ELB 지원, ExternalIP 도메인 연결

![image](https://github.com/user-attachments/assets/52accadd-4377-4fbb-9f7b-ebecca11c8d3)

### Terraform | AWS Cloud Infra

- 현재 리소스 전부 삭제 완료
- 주요 서비스별 모듈 분리로 관리 편의성 증가

#### VPC

- Internet Gateway
- EKS NodeGroup과 RDS 프라이빗 서브넷을 위한 NAT Gateway 생성
- 각 게이트웨이의 라우팅 테이블
- Jenkins 인스턴스 탄력적IP 설정

#### Subnet

- Jenkins 인스턴스 - Public
- RDS - Private
- EKS Cluster - Public
- EKS NodeGroup - Private
- EKS NodeGroup과 RDS 프라이빗 서브넷을 위한 NAT Gateway - Public

#### Security Group

- Jenkins 인스턴스 보안 그룹
- RDS 보안 그룹

#### RDS

- MySQL 인스턴스
- MySQL 8.0.35
- 프리티어 설정 생성
  - db.t3.micro
  - 20GiB
- Cloudwatch 설정
- 삭제 방지

#### EKS

- Cluster
- NodeGroup
- desired: 2
- max: 4
- min: 2
- max_unavailable: 1
- 기본 구성
  - t3.medium 2개
    - CPU 4000m
    - Memory 8192Mi
- EKS addon
- coredns
- kube-proxy
- vpc-cni
- eks-pod-identity-agent
- Cloudwatch Log Group
- IAM Roles

#### EC2

- Jenkins 인스턴스 - t3.medium / 20GB

#### ECR

- paperple-spring - 백엔드 이미지
- paperple-ai - 인공지능 이미지

![image](https://github.com/user-attachments/assets/fc9386f4-adc5-4e62-ba85-87923100e9b1)

### Jenkins | CI/CD

- Ansible로 Jenkins 서버 구축 과정 선언

- 역할 분리
- tls 인증서 발급 및 https 연결 자동화

- 백엔드/인공지능 레포의 Dockerfile, Jenkinsfile 활용
- GitHub Webhook 설정
- 각 레포 변경 사항 발생 시 CI 파이프라인 트리거
- 이미지 빌드
- 애플리케이션 실행 헬스체크 테스트
- ECR 이미지 업로드
- IMAGE_TAG 파라미터와 함꼐 CD 파이프라인 트리거
- Slack 성공/실패 알림

### ArgoCD | CD

- [Manifest Repo](https://github.com/lunch-12/pAPERPLE-cd) 추적 및 Sync
- Slack 연동 - Sync, OutOfSync, Health 알림

## Done & To-Dos

### Done

1. GitOps 구현으로 CI/CD 자동화 및 휴먼 리소스 최소화
2. CPU, 메모리 리소스 계산 후 스케일링 자동화 적용
3. NGINX Ingress Controller에서의 HTTPS와 쿠키 전달 설정
4. Terraform으로 VPC 등 인프라 구축
5. CI에서 애플리케이션 헬스체크 단계 추가

### To-Dos

단순 서비스 활용에 그치지 않고 안정성, 고가용성, 확장성을 고민한 아키텍처 구상/구현

1. 사이드카 패턴의 멀티 컨테이너로 애플리케이션 로그 수집으로 옵저버빌리티 구현
2. IAM 권한 세분화 및 최소 권한
3. Jenkins master-agent 분리 및 스팟 인스턴스 적용
4. RDS 설정 세분화
5. 애플리케이션 설정 외부화 (ENV 분리) / Secret 관리
6. 애플리케이션 레벨 무중단배포
7. Production / Staging / Dev 레벨 구분

## Blog Articles

- [[CI/CD] GitOps 환경 구축하기(1) GitOps, Kubernetes](https://velog.io/@hnnynh/CICD-%EC%BF%A0%EB%B2%84%EB%84%A4%ED%8B%B0%EC%8A%A4-GitOps-%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%B6%95%ED%95%98%EA%B8%B0-GitOps-Kubernetes)
- [[CI/CD] GitOps 환경 구축하기(2) GitHub](https://velog.io/@hnnynh/CICD-%EC%BF%A0%EB%B2%84%EB%84%A4%ED%8B%B0%EC%8A%A4-GitOps-%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%B6%95%ED%95%98%EA%B8%B0-GitHub)
- [[CI/CD] GitOps 환경 구축하기(3) Jenkins](https://velog.io/@hnnynh/CICD-%EC%BF%A0%EB%B2%84%EB%84%A4%ED%8B%B0%EC%8A%A4-GitOps-%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%B6%95%ED%95%98%EA%B8%B0-Jenkins)
- [[CI/CD] GitOps 환경 구축하기(4) ArgoCD, Kubernetes](https://velog.io/@hnnynh/CICD-%EC%BF%A0%EB%B2%84%EB%84%A4%ED%8B%B0%EC%8A%A4-GitOps-%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%B6%95%ED%95%98%EA%B8%B0-ArgoCD)
- [[K8s] HPA 설정 트러블슈팅하기](https://velog.io/@hnnynh/hpa-%EC%84%A4%EC%A0%95-%ED%8A%B8%EB%9F%AC%EB%B8%94%EC%8A%88%ED%8C%85%ED%95%98%EA%B8%B0)
- [[K8s] nginx ingress controller에서 https 적용하기](https://velog.io/@hnnynh/K8s-nginx-ingress-controller%EC%97%90%EC%84%9C-https-%EC%A0%81%EC%9A%A9%ED%95%98%EA%B8%B0)

```

```
