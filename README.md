# PAPERPLE-Infra

- Terraform으로 AWS 인프라 구축

  - 모듈 분리

  1. VPC
     - 인터넷 게이트웨이
     - NAT 게이트웨이
     - 각 게이트웨이의 라우팅 테이블
     - CI 서버 탄력적IP
  2. 서브넷
     - NAT 게이트웨이 퍼블릭 서브넷
     - CI 서버 인스턴스 퍼블릭 서브넷
     - RDS 퍼블릭 서브넷 -> 프라이빗 이동 예정
     - EKS 클러스터 퍼블릭 서브넷
     - EKS 노드그룹 프라이빗 서브넷
  3. 보안 그룹
     - CI 서버 인스턴스 보안 그룹
  4. RDS
     - MySQL 인스턴스
       - 프리티어 설정
       - Cloudwatch 설정
  5. EKS
     - 클러스터
     - 노드 그룹
     - EKS addon 추가
     - Cloudwatch 로그 그룹
     - 권한 부여한 역할 IAM
  6. EC2
     - CI 서버 인스턴스
  7. IAM (분리 예정)

- Ansible로 Jenkins 서버 구축 자동화

  - 역할 관리

- EKS로 Kubernets 클러스터 구성

  - 기본 노드 2개 - 최대 4개
  - cronjob 설정으로 뉴스 크롤링
  - 서비스 배포

    - namespace: default
    - 백엔드 파드 / AI 파드 통신
    - nginx ingress controller
      - 백엔드 서비스 ingress로 노출

  - EFK로 로그 수집
    - namespace: logging
    - ElasticSearch
    - Fluentd
    - Kibana
      - LoadBalancer 서비스로 AWS에서 ELB 지원 - ExternalIP 도메인 연결

- CI/CD

  - 백엔드 / AI 레포에 Dockerfile, Jenkinsfile 작성
  - 변경 사항 발생시 Jenkins 이미지 빌드/푸시
  - https://github.com/lunch-12/PAPERPLE-CD 에서 manifest 관리
    - 이미지 태그 갱신되면 manifest 태그 수정
    - ArgoCD 모니터링 및 AutoSync

- 리소스 결정 고려 사항

  - 인스턴스 사양
  - 개발 과정
    - 마스터노드 1개로 리소스 사용 최소화
    - EKS 노드 그룹의 노드 2개 보장으로 최소한의 가용성 보장
    - 파드 2개로 RollingUpdate 무중단 보장
      - hpa: https://kubernetes.io/ko/docs/tasks/run-application/horizontal-pod-autoscale/
      - slo: 최소한의 가용성으로 설정
  - 스트레스 및 에러 테스트 수행 (필요)
