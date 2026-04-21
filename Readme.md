.
├── backend-setup/
│   └── main.tf
├── modules/
│   ├── kms/
│   ├── vpc/
│   ├── rds/
│   ├── secrets/
│   ├── ecr/
│   ├── eks/
│   ├── s3/
│   ├── monitoring/
│   ├── security/
│   └── amplify/
├── k8s/
│   ├── secrets.yaml
│   ├── api-service.yaml
│   ├── auth-service.yaml
│   ├── document-service.yaml
│   ├── notification-service.yaml
│   └── ingress.yaml
├── main.tf
├── variables.tf
├── outputs.tf
└── backend.tf