# A3/README.md

## A3: Monitoring and Bandwidth Measurement

### Purpose

This artifact provides the monitoring configuration and the bandwidth-measurement procedure used in the paper.

### Contents

* `docker-compose.yaml` – launches the monitoring stack.
* `metrics/`

  * `prometheus.yml`
  * `grafana-datasources.yml`
* `profile.sh` – executes NVIDIA Nsight Systems profiling.
* `1g10gb_mig_gpu090.nsys-rep`
* `1g20gb_mig_gpu090.nsys-rep`

### Prerequisites

* Docker Engine
* NVIDIA Container Toolkit
* DCGM Exporter 4.4.1-4.5.2
* Prometheus 3.6.0
* Grafana 12.2
* NVIDIA Nsight Systems 2025.3.1.90

### Monitoring Setup

Start the monitoring stack:

```bash
docker compose up -d

### Expected Output

The monitoring stack reports GPU memory usage and vLLM runtime metrics. The Nsight Systems reports included in this artifact reproduce the bandwidth measurements discussed in Section III-B.
