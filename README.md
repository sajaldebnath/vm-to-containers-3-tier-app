# VM to Containers: Modernizing a 3-Tier Application
This repository contains my end-to-end modernization of a VM-based 3-tier demo application into a containerized and Kubernetes-deployable platform.

The project preserves the original application architecture while progressively evolving it through Docker, Docker Compose, and Kubernetes.

It is both a runnable application and a practical reference implementation for engineers learning how to modernize traditional VM-based applications.

## Architecture Overview

| Tier | Technology | Role |
|------|------------|------|
| Web Tier | NGINX | Reverse proxy and entry point |
| Application Tier | Flask | UI and application logic |
| API Tier | FastAPI | CRUD API layer |
| Database | MongoDB | Persistent data store |

## Modernization Journey

This project started as a VM-based 3-tier application and was modernized in stages:

1. Understand the original VM-based architecture
2. Remove infrastructure-specific assumptions
3. Containerize the application with Docker
4. Run the stack with Docker Compose
5. Prepare the application for Kubernetes
6. Deploy the application on Kubernetes

7. ## Repository Structure

- `app/` — Flask application tier
- `db/` — FastAPI backend tier and seed data
- `mongo-init/` — MongoDB bootstrap image and script
- `web/` — NGINX configuration
- `k8s/` — Kubernetes manifests
- `docs/` — diagrams, blog-series markdown, and architecture notes

- ## Prerequisites

### For Docker Compose
- Docker
- Docker Compose

### For Kubernetes
- Kubernetes cluster
- `kubectl`
- Docker registry access for custom images
- Ingress controller
- Minikube users: `minikube tunnel`

## Run with Docker Compose

Build and start the full stack:

```bash
docker compose up --build

Access:
	•	Main UI: http://localhost
	•	Flask app directly: http://localhost:8080
	•	FastAPI directly: http://localhost:8000

Note: MongoDB is initialized through the containerized init pattern.

---

## 8. Running on Kubernetes

This should be a clean sequence.

```md
## Run on Kubernetes

### Build and push images

```bash
docker build -t <dockerhub-user>/demo-app:latest ./app
docker build -t <dockerhub-user>/demo-db-api:latest ./db
docker build -t <dockerhub-user>/demo-mongo-init:latest ./mongo-init

docker push <dockerhub-user>/demo-app:latest
docker push <dockerhub-user>/demo-db-api:latest
docker push <dockerhub-user>/demo-mongo-init:latest

### Deploy manifests
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/mongo-statefulset.yaml
kubectl delete job mongo-init -n demo-3tier-app --ignore-not-found
kubectl apply -f k8s/mongo-init-job.yaml
kubectl apply -f k8s/db-api-deployment.yaml
kubectl apply -f k8s/app-deployment.yaml
kubectl apply -f k8s/web-deployment.yaml
kubectl apply -f k8s/ingress.yaml

### Minikube only
minikube tunnel

---

## 9. Access URLs

```md
## Accessing the Application

### Through Ingress
- Main UI: `http://<INGRESS-IP>`
- Swagger UI: `http://<INGRESS-IP>/docs`
- ReDoc: `http://<INGRESS-IP>/redoc`

### Direct tier access
- Flask app: `http://<MINIKUBE-IP>:30080`
- FastAPI API: `http://<MINIKUBE-IP>:30000`

## MongoDB initialization note

## Database Initialization

MongoDB is initialized using a dedicated Kubernetes Job backed by a custom `demo-mongo-init` image.

That image contains:
- `MOCK_DATA.json`
- `init-mongo.sh`
- MongoDB client tools

The initialization process:
1. waits for MongoDB
2. imports seed data
3. creates required indexes

## Blog Series

This repository accompanies the blog series:

- Part 1 — Understanding the Original 3-Tier Architecture
- Part 2 — Preparing the Application for Containerization
- Part 3 — Containerizing the Application with Docker
- Part 4 — Running the Application with Docker Compose
- Part 5 — Preparing the Application for Kubernetes
- Part 6 — Deploying the Application on Kubernetes

Read the full series at:
[https://sajaldebnath.com](https://sajaldebnath.com)

## Future Roadmap

Possible next steps:
- Add health checks and probes
- Introduce Helm packaging
- Add CI/CD pipeline
- Add observability
- Evolve toward a microservices architecture

## License

This project is licensed under the MIT License.






