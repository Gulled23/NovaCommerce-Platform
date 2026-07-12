# NovaCommerce Platform AWS Network Architecture Design

## VPC CIDR

VPC Name: novacommerce-prod-vpc

CIDR Block:

10.0.0.0/16

---

## Availability Zones

The architecture will use three Availability Zones for high availability:

- eu-west-2a
- eu-west-2b
- eu-west-2c

---

## Public Subnets

Public subnets are used for resources that require internet access, such as load balancers and NAT gateways.

| Subnet Name | CIDR | Availability Zone |
|---|---|---|
| novacommerce-public-subnet-2a | 10.0.1.0/24 | eu-west-2a |
| novacommerce-public-subnet-2b | 10.0.2.0/24 | eu-west-2b |
| novacommerce-public-subnet-2c | 10.0.3.0/24 | eu-west-2c |

---

## Private Subnets

Private subnets host application workloads that should not be directly accessible from the internet.

| Subnet Name | CIDR | Availability Zone |
|---|---|---|
| novacommerce-private-subnet-2a | 10.0.11.0/24 | eu-west-2a |
| novacommerce-private-subnet-2b | 10.0.12.0/24 | eu-west-2b |
| novacommerce-private-subnet-2c | 10.0.13.0/24 | eu-west-2c |

---

## Internet Gateway

Internet Gateway:

`novacommerce-prod-igw`

Purpose:

- Provides internet connectivity to public subnets.
- Allows inbound and outbound traffic for approved public resources.

---

## NAT Gateway

NAT Gateways allow private subnet resources to access the internet for updates while preventing inbound internet access.

| NAT Gateway | Availability Zone |
|---|---|
| novacommerce-nat-2a | eu-west-2a |
| novacommerce-nat-2b | eu-west-2b |
| novacommerce-nat-2c | eu-west-2c |

---

## Route Tables

### Public Route Table

Name:

`novacommerce-public-route-table`

Routes:

| Destination | Target |
|---|---|
| 10.0.0.0/16 | Local |
| 0.0.0.0/0 | Internet Gateway |

---

### Private Route Table

Name:

`novacommerce-private-route-table`

Routes:

| Destination | Target |
|---|---|
| 10.0.0.0/16 | Local |
| 0.0.0.0/0 | NAT Gateway |

---

## Security Groups

### Load Balancer Security Group

Name:

`novacommerce-alb-sg`

Rules:

Inbound:
- HTTP 80 from internet
- HTTPS 443 from internet

Outbound:
- Allow traffic to application layer

---

### Application Security Group

Name:

`novacommerce-app-sg`

Rules:

Inbound:
- Allow traffic only from Load Balancer Security Group

Outbound:
- Allow required application communication

---

### Database Security Group

Name:

`novacommerce-db-sg`

Rules:

Inbound:
- Allow database connections only from application security group

---

## Naming Convention

Format:

<application>-<environment>-<resource>-<identifier>

Examples:

novacommerce-prod-vpc
novacommerce-prod-public-subnet-2a
novacommerce-prod-private-subnet-2a
novacommerce-prod-db-sg

---

## Tagging Strategy

All AWS resources must use standard tags to support ownership, cost tracking, automation, and resource management.

| Tag | Example |
|---|---|
| Name | novacommerce-prod-vpc |
| Application | NovaCommerce |
| Environment | Production |
| Owner | Platform Engineering |
| ManagedBy | Terraform |
| Project | NovaCommerce Platform |

Tagging standards:

- All AWS resources must include required tags.
- Tags must be consistent across all environments.
- ManagedBy must identify Terraform-managed resources.