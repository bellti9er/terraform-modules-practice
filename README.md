# Terraform Modularization Pracitce

> 간단한 연습 과정에서 참고했던 자료는 `code`와 `./modules/vpc/README.md`에 기재하였습니다.

</br>

프로젝트는 아래와 같은 구조를 가지고 있습니다.

```
infrastructure
├── global
│   └── s3
│       ├── backend.tf
│       ├── main.tf
│       └── outputs.tf
│
├── dev
│   ├── service
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   └── outputs.tf
│   │
│   └── vpc
│       ├── backend.tf
│       ├── main.tf
│       └── outputs.tf
│
└── modules
    └── vpc
        ├── main.tf
        ├── outputs.tf
        └── vars.tf
```

- global
  - 일반적으로 여러 환경(dev, staging, prod)에 걸쳐 공통으로 사용되는 AWS 리소스를 정의하는 테라폼 코드를 담고 있습니다.

- dev
  - dev 환경의 리소스를 정의한 공간입니다.

- modules
  - 여러 Terraform 구성 간에 재사용 가능한 code block이 위치하는 공간입니다.

</br>

각 하위 디렉토리들은 다음과 같은 파일 구성을 가지고 있습니다. 

```
└── services
    └── backend
        ├── backend.tf
        ├── main.tf
        ├── outputs.tf
        └── vars.tf
```

- backend.tf
  - terraform의 state를 관리 및 공유하는 백엔드 설정을 정의하는 파일입니다.
  - 각 디렉토리가 독립된 Terraform 실행 단위이기 떄문에, 이러한 디렉토리마다 독립된 state file이 생성되고 관리되어야 합니다.
  - 그래서 Terraform 상태를 저장하고 관리하기 위해 AWS S3 버킷을 활용합니다. 이는 Terraform이 관리하는 인프라의 상태를 안전하게 유지하고, 여러 개발자가 인프라를 관리할 때의 문제를 방지하는데 도움이 됩니다.

- main.tf
  - Terraform 설정 코드 파일입니다.

- outputs.tf
  - 해당 디렉토리가 Terraform에 의해 실행된 후 생성될 output들을 정의해놓은 파일입니다.

- vars.tf
  - variable들을 지정해 놓은 파일입니다.

