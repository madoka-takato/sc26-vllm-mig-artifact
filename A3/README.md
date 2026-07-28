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

Prometheus collects GPU metrics from DCGM Exporter and vLLM runtime metrics exposed through the `/metrics` endpoint, including GPU memory usage (`DCGM_FI_DEV_FB_USED`) and request queue metrics (`vllm:num_requests_waiting`).

Grafana visualizes the collected metrics during execution. The dashboards are not included in this repository; import them from the Grafana Dashboard Library (<https://grafana.com/grafana/dashboards/>) after launching Grafana.

## Bandwidth Measurement

The GPU memory bandwidth measurement is performed using NVIDIA Nsight Systems.

Procedure:

1. Launch the target vLLM container with the specified MIG profile
   (`1g.10gb` or `1g.20gb`) using the provided Docker command.

2. Start the vLLM server under NVIDIA Nsight Systems profiling with the
   provided profiling command. The profiling configuration enables GPU metrics
   collection, including **DRAM Bandwidth (%)**.

3. Execute the benchmark workload following the procedure described in A1.

4. Open the generated `.nsys-rep` file with NVIDIA Nsight Systems and record the maximum observed value of **DRAM Bandwidth (%)** during the benchmark execution.

5. Multiply the recorded DRAM Bandwidth percentage by the theoretical peak
   memory bandwidth of the corresponding MIG profile to obtain the achieved GPU
   memory bandwidth.
   
## Expected Output

The monitoring stack reports GPU memory usage and vLLM runtime metrics. The provided Nsight Systems report files, `1g10gb_mig_gpu090.nsys-rep` and `1g20gb_mig_gpu090.nsys-rep`, contain the profiling results used to reproduce the peak memory bandwidth measurements discussed in Section III-B.
