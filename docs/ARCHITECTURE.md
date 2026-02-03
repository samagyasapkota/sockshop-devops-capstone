# Architecture Documentation

## System Architecture
```mermaid
graph TB
    subgraph "AWS Cloud"
        subgraph "VPC - 10.0.0.0/16"
            subgraph "Public Subnet"
                ALB[Application Load Balancer]
                NAT[NAT Gateway]
            end
            
            subgraph "Private Subnet"
                subgraph "EKS Cluster"
                    Frontend[Front-End Service]
                    Catalogue[Catalogue Service]
                    Carts[Carts Service]
                    Orders[Orders Service]
                    Payment[Payment Service]
                    Shipping[Shipping Service]
                    User[User Service]
                    Queue[Queue Master]
                end
                
                RDS[(RDS MySQL)]
            end
        end
        
        ECR[Amazon ECR<br/>Container Registry]
        
        subgraph "Monitoring"
            Prometheus[Prometheus]
            Grafana[Grafana]
        end
    end
    
    Users[Users] --> ALB
    ALB --> Frontend
    Frontend --> Catalogue
    Frontend --> Carts
    Frontend --> Orders
    Frontend --> User
    
    Orders --> Payment
    Orders --> Shipping
    Orders --> Queue
    
    Catalogue --> RDS
    Carts --> RDS
    Orders --> RDS
    User --> RDS
    
    Prometheus -.->|Scrapes Metrics| Frontend
    Prometheus -.->|Scrapes Metrics| Catalogue
    Grafana -.->|Queries| Prometheus
    
    ECR -.->|Pull Images| EKS
```

## Network Architecture

- **VPC CIDR**: 10.0.0.0/16
- **Public Subnets**: 10.0.1.0/24, 10.0.2.0/24
- **Private Subnets**: 10.0.3.0/24, 10.0.4.0/24
- **Availability Zones**: 2 AZs for high availability

## Components

### Compute
- **EKS Cluster**: Kubernetes 1.29
- **Node Groups**: 2 t3.medium instances
- **Auto Scaling**: Enabled

### Storage
- **RDS MySQL**: db.t3.micro (Multi-AZ)
- **EBS Volumes**: gp3, 20GB per node

### Networking
- **Load Balancer**: Application Load Balancer
- **Security Groups**: Configured for least privilege
- **VPC Peering**: Not configured

### Container Registry
- **ECR Repositories**: 12 repositories (one per microservice)
- **Image Scanning**: Enabled on push
