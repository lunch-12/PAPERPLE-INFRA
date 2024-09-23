# PAPERPLE-Infra

- [Paperple](#paperple)
- [Tech Stack](#tech-stack)
- [Roles and Responsibilities](#roles-and-responsibilities)
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

## Roles and Responsibilities

### Cloud Team | 한윤호 | hnnynh

[GitHub](https://github.com/hnnynh) | [Blog](https://velog.io/@hnnynh/posts) | [LinkedIn](https://www.linkedin.com/in/%EC%9C%A4%ED%98%B8-%ED%95%9C-759471291/)

1. AWS Cloud Infra 설계 및 구성
2. GitOps 기반의 Jenkins, ArgoCD 활용 CI/CD
3. EKS 배포 및 스케일링 자동화

## CICD Flow

![cicd drawio](https://github.com/user-attachments/assets/34ef8115-f241-43fe-8d4f-20255b33f1a1)

## Task Details

### Kubernetes | Deployment

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
