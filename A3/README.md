# A3: Monitoring and Bandwidth Measurement

## Purpose

This artifact provides the monitoring configuration and the
bandwidth-measurement procedure used in the paper.

## Contents

- `docker-compose.yaml` — launches the monitoring stack.
- `metrics/`
  - `prometheus.yml`
  - `grafana-datasources.yml`
- `profile.sh` — executes NVIDIA Nsight Systems profiling.
- `nsight_reports/` — Nsight Systems profiling results.
  - `1g10gb_mig_gpu090.nsys-rep`
  - `1g20gb_mig_gpu090.nsys-rep`

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

Prometheus collects:

- GPU memory usage (`DCGM_FI_DEV_FB_USED`)
- GPU utilization and related GPU metrics from DCGM Exporter
- vLLM runtime metrics exposed through the `/metrics` endpoint of each vLLM server
- Queue-related metrics, including `vllm:num_requests_waiting`

Grafana visualizes the collected metrics during execution. The dashboards
are not included in this repository; import them from the Grafana Dashboard
Library (<https://grafana.com/grafana/dashboards/>) after launching Grafana.

Set the Prometheus instance (`http://prometheus:9090`) as the data source when importing.

## Bandwidth Measurement

The memory bandwidth is measured with NVIDIA Nsight Systems.

Procedure:

1. Launch the target vLLM server (1g.10gb or 1g.20gb).
2. Execute the profiling command using `profile.sh`.
3. Open the generated `.nsys-rep` file with NVIDIA Nsight Systems.
4. Navigate to **GPU Metrics**.
5. Record the maximum value of **DRAM Bandwidth (%)**.
6. Multiply this percentage by the theoretical peak memory bandwidth of the
   corresponding MIG profile to obtain the peak GPU memory bandwidth.

## Expected Output

The monitoring stack reports GPU memory usage and vLLM runtime metrics. The provided Nsight Systems report files, `1g10gb_mig_gpu090.nsys-rep` and `1g20gb_mig_gpu090.nsys-rep`, contain the profiling results used to reproduce the peak memory bandwidth measurements discussed in Section III-B.
