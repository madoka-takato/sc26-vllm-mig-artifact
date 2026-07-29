# A3: Monitoring and Bandwidth Measurement

## Purpose

This artifact provides the monitoring configuration and the
bandwidth-measurement procedure used in the paper.

## Contents

- `docker-compose.yaml` — launches the monitoring stack.
- `metrics/`
  - `prometheus.yml`
  - `grafana-datasources.yml`
- `nsys_bandwidth.sh` — executes NVIDIA Nsight Systems profiling.

## Prerequisites

- Docker Engine
- NVIDIA Container Toolkit
- DCGM Exporter 4.4.1-4.5.2
- Prometheus 3.6.0
- Grafana 12.2
- NVIDIA Nsight Systems 2025.3.1.90

## Monitoring Setup

Start the monitoring stack:

​```bash
docker compose up -d
​```

Prometheus collects GPU metrics from DCGM Exporter and vLLM runtime metrics
exposed through the `/metrics` endpoint.

The Grafana dashboards are not included in this repository. After launching
Grafana, import the required dashboards (the NVIDIA DCGM Dashboard for
Kubernetes (MIG & Non-MIG GPUs) and the vLLM dashboard) from the
Grafana Dashboard Library:

<https://grafana.com/grafana/dashboards/>

## Bandwidth Measurement

The GPU memory bandwidth measurement is performed using NVIDIA Nsight Systems.

Procedure:

1. Launch the target vLLM container with the specified MIG profile
   (`1g.10gb` or `1g.20gb`) using the provided Docker command.

2. Start the vLLM server using NVIDIA Nsight Systems profiling
   (`nsys profile`) with the provided profiling command.
   The profiling configuration enables GPU metric collection, including
   **DRAM Bandwidth (%)**.

3. Execute the benchmark workload following the procedure described in A1.

4. Open the generated `.nsys-rep` file with NVIDIA Nsight Systems and record the maximum observed value of **DRAM Bandwidth (%)** during the benchmark execution.

5. Multiply the recorded DRAM Bandwidth percentage by the theoretical peak
   memory bandwidth of the corresponding MIG profile to obtain the achieved GPU
   memory bandwidth.
   
## Expected Output

The monitoring stack reports GPU metrics and vLLM runtime metrics.

The Nsight Systems profiling procedure generates `.nsys-rep` files, which can
be opened with NVIDIA Nsight Systems to inspect GPU metrics, including DRAM Bandwidth (%).
