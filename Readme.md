# 1. Init and apply Terraform
terraform init
terraform plan -out=tfplan
terraform apply tfplan

# 2. Connect to EKS
aws eks update-kubeconfig --region eu-central-1 --name production-eks

# 3. Deploy Kubernetes manifests
kubectl apply -f k8s/secrets.yaml
kubectl apply -f k8s/api-service.yaml
kubectl apply -f k8s/auth-service.yaml
kubectl apply -f k8s/document-service.yaml
kubectl apply -f k8s/notification-service.yaml
kubectl apply -f k8s/ingress.yaml

# 4. Verify everything
kubectl get pods -n production
kubectl get ingress -n production
kubectl get svc -n production





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