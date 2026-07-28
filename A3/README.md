# A3/README.md

## A3: Monitoring and Bandwidth Measurement

### Purpose

This artifact provides the monitoring configuration and the bandwidth-measurement procedure used in the paper.

### Contents

* `docker-compose.yaml` – launches the monitoring stack.
* `metrics/`

  * `prometheus.yml`
  * `grafana-datasources.yml`
  * `grafana_dashboards/`
* `profile.sh` – executes NVIDIA Nsight Systems profiling.
* `1g10gb_mig_gpu090.nsys-rep`
* `1g20gb_mig_gpu090.nsys-rep`

### Prerequisites

* Docker Engine
* NVIDIA Container Toolkit
* DCGM Exporter 4.4.1-4.5.2
* Prometheus v3.6.0
* Grafana 12.2
* NVIDIA Nsight Systems 2025.3.1.90

### Monitoring

Start the monitoring stack:

```bash
docker compose up -d
```

Prometheus collects:

* GPU memory usage (`DCGM_FI_DEV_FB_USED`)
* vLLM runtime metrics
* Queue-related metrics

Grafana dashboards visualize these metrics during execution.

### Bandwidth Measurement

1. Launch the target vLLM server.
2. Execute the profiling command using `profile.sh`.
3. Open the generated `.nsys-rep` file with NVIDIA Nsight Systems.
4. Navigate to **GPU Metrics**.
5. Record the maximum value of **DRAM Bandwidth (%)**.
6. Multiply this percentage by the theoretical maximum memory bandwidth of the corresponding MIG profile to obtain the peak memory bandwidth.

### Expected Output

The monitoring stack reports GPU memory usage and vLLM runtime metrics. The Nsight Systems reports included in this artifact reproduce the bandwidth measurements discussed in Section III-B.
