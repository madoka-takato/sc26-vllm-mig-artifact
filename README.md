# Artifacts for "Performance Characterization of GPU Sharing Strategies for LLM Inference"

The artifacts reproduce the performance evaluation of two GPU-sharing
configurations for concurrent LLM inference on a single NVIDIA H100 PCIe GPU:
software-based sharing (*vLLM-only*) and hardware-level partitioning with
Multi-Instance GPU (*vLLM+MIG*).

## Repository Structure

- `A1_single_server/` — single-server characterization of individual MIG
  profiles (reproduces Figs. 1–2).
- `A2_multi_server/` — comparison of *vLLM-only* and *vLLM+MIG* while
  varying the number of concurrent servers and the offered load
  (reproduces Figs. 3–6).
- `A3_monitoring/` — monitoring stack (DCGM Exporter, Prometheus, Grafana)
  and the Nsight Systems bandwidth measurement.

Each directory contains its own README with detailed instructions.

## Requirements

### Hardware
- NVIDIA H100 PCIe GPU (80 GB), MIG-capable
- (Our system: PRIMERGY RX2540 M6, 2× Intel Xeon Gold 6430, 512 GB DDR5)

### Software
- Rocky Linux 9.5
- NVIDIA Driver 535.288.01 (CUDA 12.2, as reported by `nvidia-smi`)
- Docker Engine 29.3.0
- NVIDIA Container Toolkit 1.19.0
- Container image: `vllm/vllm-openai:v0.19.0`
- tmux (for A2)
- NVIDIA Nsight Systems 2025.3.1.90 (for A3)

### Model and Dataset
- Model: `LiquidAI/LFM2.5-1.2B-Instruct` (downloaded automatically by vLLM)
- Prompts: ShareGPT_V3 dataset （URL）

## Reproduction Overview

1. Set up the environment (see Requirements).
2. (Optional) Start the monitoring stack in `A3/` to record
   GPU memory usage and queueing metrics during the experiments.
3. Run `A1_single_server/` to reproduce Figs. 1–2.
4. Run `A2_multi_server/` to reproduce Figs. 3–6.
5. Use `A3_monitoring/` for the bandwidth measurement (Section III-B).
