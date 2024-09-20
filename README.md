# PAPERPLE-Infra

서비스 소개
담당한 작업들
세부사항

- Kubernetes
- Terraform
- Jenkins
- ArgoCD
  고민 및 개선 사항
  블로그 아티클

## Paperple

서비스 소개

## Role

담당한 작업들

## Tech Stack

| **CSP**                                                                                                        | **Infra**                                                                                                        | **Deployment**                                                                                                 | **CI/CD**                                                                                                                                                                                                     | **Image**                                                                                              |
| -------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| <img src="https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonwebservices&logoColor=white"> | <img src="https://img.shields.io/badge/Terraform-844FBA?style=for-the-badge&logo=terraform&logoColor=white"></a> | <img src="https://img.shields.io/badge/kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white"> | <img src="https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white"> <img src="https://img.shields.io/badge/ArgoCD-EF7B4D?style=for-the-badge&logo=argo&logoColor=white"> | <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=Docker&logoColor=white"> |

## Details

세부사항

## Dive & To Do

고민 및 개선 사항

## Articles

- [[CI/CD] GitOps 환경 구축하기(1) GitOps, Kubernetes](https://velog.io/@hnnynh/CICD-%EC%BF%A0%EB%B2%84%EB%84%A4%ED%8B%B0%EC%8A%A4-GitOps-%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%B6%95%ED%95%98%EA%B8%B0-GitOps-Kubernetes)
- [[CI/CD] GitOps 환경 구축하기(2) GitHub](https://velog.io/@hnnynh/CICD-%EC%BF%A0%EB%B2%84%EB%84%A4%ED%8B%B0%EC%8A%A4-GitOps-%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%B6%95%ED%95%98%EA%B8%B0-GitHub)
- [[CI/CD] GitOps 환경 구축하기(3) Jenkins](https://velog.io/@hnnynh/CICD-%EC%BF%A0%EB%B2%84%EB%84%A4%ED%8B%B0%EC%8A%A4-GitOps-%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%B6%95%ED%95%98%EA%B8%B0-Jenkins)
- [[CI/CD] GitOps 환경 구축하기(4) ArgoCD, Kubernetes](https://velog.io/@hnnynh/CICD-%EC%BF%A0%EB%B2%84%EB%84%A4%ED%8B%B0%EC%8A%A4-GitOps-%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%B6%95%ED%95%98%EA%B8%B0-ArgoCD)
- [[K8s] HPA 설정 트러블슈팅하기](https://velog.io/@hnnynh/hpa-%EC%84%A4%EC%A0%95-%ED%8A%B8%EB%9F%AC%EB%B8%94%EC%8A%88%ED%8C%85%ED%95%98%EA%B8%B0)
- [[K8s] nginx ingress controller에서 https 적용하기](https://velog.io/@hnnynh/K8s-nginx-ingress-controller%EC%97%90%EC%84%9C-https-%EC%A0%81%EC%9A%A9%ED%95%98%EA%B8%B0)
- []()
  블로그 아티클
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
     - RDS 프라이빗 서브넷
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
  7. ECR
     - 백엔드, AI 이미지 관리 프라이빗 리포지토리

- Ansible로 Jenkins 서버 구축 자동화

  - 역할 관리
  - tls 인증서 발급 및 https 연결 자동화

- EKS로 Kubernets 클러스터 구성

  - 기본 노드 2개 - 최대 4개
  - ~~cronjob 설정으로 뉴스 크롤링~~ - AI 서버 내부에서 스케줄링
  - 서비스 배포

    - namespace: default
    - 백엔드 파드 / AI 파드 통신
    - nginx ingress controller
      - 백엔드 서비스 ingress로 노출
      - 쿠키, CORS 설정으로 OAuth 로그인 연동 성공

  - EFK로 로그 수집
    - namespace: logging
    - ElasticSearch
    - Fluentd
    - Kibana
      - LoadBalancer 서비스로 AWS에서 ELB 지원 - ExternalIP 도메인 연결

- CI/CD

  - 백엔드 / AI 레포에 Dockerfile, Jenkinsfile 작성
  - 변경 사항 발생시 Jenkins가 이미지 빌드/푸시
  - https://github.com/lunch-12/PAPERPLE-CD 에서 manifest 관리
    - 이미지 태그 갱신되면 manifest 태그 수정
    - ArgoCD 모니터링
  - Slack 연동
    - Jenkins: CI (이미지 빌드, 실행 테스트), CD 트리거
      - 애플리케이션 실행 헬스체크 단계 추가
    - ArgoCD: Sync, Health 알림

- 리소스 결정 고려 사항

  - 인스턴스 사양
    - 노드 그룹
      - t3.medium 2개
        - CPU 4000m
        - Memory 8192Mi
  - 개발 과정
    - 마스터노드 1개로 리소스 사용 최소화
    - EKS 노드 그룹의 노드 2개 보장으로 최소한의 가용성 보장
    - 파드 2개로 RollingUpdate 무중단 보장 -> 컨테이너 입장에서의 무중단 배포...
      - hpa: https://kubernetes.io/ko/docs/tasks/run-application/horizontal-pod-autoscale/
      - slo (확인 필요)
  - 안정성
    - 수평적 확장 - hpa 적용
    - 수직적 확장 - cluster autoscaling
