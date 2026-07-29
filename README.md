# Artifact: Performance Characterization of GPU Sharing Strategies for LLM Inference

The artifact reproduces the performance evaluation of two GPU-sharing
configurations for concurrent LLM inference on a single NVIDIA H100 PCIe GPU:
software-based sharing (*vLLM-only*) and hardware-level partitioning using
NVIDIA Multi-Instance GPU (*vLLM+MIG*).

## Repository Structure

- `A1/` — single-server performance characterization of *vLLM-only*
  and MIG-based configurations (reproduces Figs. 1–2).
- `A2/` — comparison of *vLLM-only* and *vLLM+MIG* configurations
  with different numbers of concurrent servers and workload intensities
  (reproduces Figs. 3–6).
- `A3/` — monitoring stack (DCGM Exporter, Prometheus, Grafana)
  and GPU memory bandwidth measurement using NVIDIA Nsight Systems.

Each directory contains its own README with detailed instructions.

## Requirements

### Hardware

- GPU: NVIDIA H100 PCIe ×1
- GPU Memory: 80 GB HBM3

### Software

- Rocky Linux 9.5
- NVIDIA Driver 535.288.01
- Docker Engine 29.3.0
- NVIDIA Container Toolkit 1.19.0
- vLLM Docker image: `vllm/vllm-openai:v0.19.0`
- NVIDIA Nsight Systems 2025.3.1.90 (used for GPU memory bandwidth measurement in A3)

### Model and Dataset

- Model: `LiquidAI/LFM2.5-1.2B-Instruct`
- Dataset: ShareGPT_V3  
  https://huggingface.co/datasets/anon8231489123/ShareGPT_Vicuna_unfiltered

## Reproduction Overview

1. Set up the environment (see Requirements).
2. (Optional) Start the monitoring stack in `A3/` to collect
   GPU and vLLM runtime metrics during the experiments.
3. Run `A1/` to reproduce Figs. 1–2.
4. Run `A2/` to reproduce Figs. 3–6.
5. Use `A3/` for the bandwidth measurement described in Section III-B.
