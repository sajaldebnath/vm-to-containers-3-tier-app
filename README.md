# VM to Containers: Modernizing a 3-Tier Application

This repository contains an end-to-end modernization of a VM-based 3-tier application into a containerized and Kubernetes-ready platform.

This is not a greenfield application.

It is a real transformation of an existing system — taking a VM-based architecture and progressively evolving it into a modern, portable, and cloud-native deployment.

This project serves two purposes:

- A **fully runnable application**
- A **reference implementation for application modernization**

---

# Architecture Overview

| Tier | Technology | Role |
|------|------------|------|
| Web Tier | NGINX | Reverse proxy and entry point |
| Application Tier | Flask | UI and business logic |
| API Tier | FastAPI | Backend API layer |
| Database | MongoDB | Persistent datastore |

---

# Modernization Journey

This project follows a structured transformation path:

1. Understand the original VM-based architecture  
2. Remove infrastructure-specific dependencies  
3. Containerize each component using Docker  
4. Run the full stack using Docker Compose  
5. Prepare the application for Kubernetes  
6. Deploy the application on Kubernetes  

The goal is to demonstrate **how to modernize without rewriting the application**.

---

# Repository Structure

vm-to-containers-3tier-app/
│
├── app/                    # Flask application tier
├── db/                     # FastAPI backend + seed data
├── mongo-init/             # MongoDB initialization image + script
├── web/                    # NGINX configuration
├── k8s/                    # Kubernetes manifests
├── docs/                   # Diagrams, blog content, architecture notes
├── docker-compose.yml
├── README.md
└── LICENSE

---

# Prerequisites

## For Docker Compose
- Docker
- Docker Compose

## For Kubernetes
- Kubernetes cluster (Minikube, Kind, or Cloud)
- `kubectl`
- Docker Hub / container registry access
- Ingress Controller (NGINX recommended)

### Minikube Users
minikube tunnel

---

# Running with Docker Compose

This is the fastest way to run the application locally.

## Start the application

docker compose up –build

## Access the application

| Component | URL |
|----------|-----|
| Main UI (NGINX) | http://localhost |
| Flask App | http://localhost:8080 |
| FastAPI | http://localhost:8000 |
| Swagger UI | http://localhost:8000/docs |

---

# Running on Kubernetes

## Step 1 — Build and Push Images

Replace `<dockerhub-user>` with your username.

docker build -t <dockerhub-user>/demo-app:latest ./app
docker build -t <dockerhub-user>/demo-db-api:latest ./db
docker build -t <dockerhub-user>/demo-mongo-init:latest ./mongo-init

docker push <dockerhub-user>/demo-app:latest
docker push <dockerhub-user>/demo-db-api:latest
docker push <dockerhub-user>/demo-mongo-init:latest

---

## Step 2 — Deploy Application

kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/mongo-statefulset.yaml

kubectl delete job mongo-init -n demo-3tier-app –ignore-not-found
kubectl apply -f k8s/mongo-init-job.yaml

kubectl apply -f k8s/db-api-deployment.yaml
kubectl apply -f k8s/app-deployment.yaml
kubectl apply -f k8s/web-deployment.yaml
kubectl apply -f k8s/ingress.yaml

---

## Step 3 — Verify Deployment

kubectl get pods -n demo-3tier-app
kubectl get svc -n demo-3tier-app
kubectl get ingress -n demo-3tier-app

---

# Accessing the Application

## Through Ingress

http://<ingreaa IP>

---

## Direct Access (for testing)

| Service | URL |
|--------|-----|
| Flask App | http://<MINIKUBE-IP>:30080 |
| FastAPI API | http://<MINIKUBE-IP>:30000 |

---

# Database Initialization

MongoDB is initialized automatically using a Kubernetes Job.

## Custom Image: `demo-mongo-init`

This image contains:
- `MOCK_DATA.json`
- `init-mongo.sh`
- MongoDB client tools

## What the Job does

1. Waits for MongoDB to be ready  
2. Imports seed data  
3. Creates indexes  

This replaces the manual steps previously required in the VM-based setup.

---

# Original VM-Based Deployment

It contained the original startup scripts used in the VM deployment.

These scripts:

- injected FQDNs
- modified configs dynamically
- handled application startup sequencing

They are preserved for **learning and comparison only**.

---

# Key Learnings

- VM-based applications can be modernized incrementally  
- Containerization improves portability  
- Kubernetes replaces manual orchestration  
- Jobs, ConfigMaps, and Services replace startup scripts  
- Architecture evolves without requiring a full rewrite  

---

# Blog Series

This repository accompanies the blog series:

**VM to Containers: Modernizing a 3-Tier Application**

- Part 1 — Understanding the Original Architecture  
- Part 2 — Preparing for Containerization  
- Part 3 — Containerizing with Docker  
- Part 4 — Running with Docker Compose  
- Part 5 — Preparing for Kubernetes  
- Part 6 — Deploying on Kubernetes  

Read the full series at:

👉 https://sajaldebnath.com

---

# Future Enhancements

- Helm chart packaging  
- CI/CD pipeline integration  
- Observability (Prometheus, Grafana)  
- Horizontal scaling  
- Microservices refactoring  

---

# License

This project is licensed under the MIT License.












