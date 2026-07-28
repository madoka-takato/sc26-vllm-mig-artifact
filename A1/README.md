# A1/README.md

## A1: Single-Server Characterization

### Purpose

This artifact reproduces the single-server experiments presented in Figs. 1 and 2 of the paper.

### Contents

* `run_vllm_only.sh` – launches a vLLM server without MIG.
* `run_mig_single.sh` – launches a vLLM server on a specified MIG profile.
* `benchmark.sh` – executes `vllm bench serve`.
* `example_outputs/` – example benchmark outputs.

### Prerequisites

* Docker Engine
* NVIDIA Container Toolkit
* NVIDIA H100 GPU
* NVIDIA Driver 535.288.01
* CUDA 12.2
* Container image `vllm/vllm-openai:v0.19.0`

### Reproducing Fig. 1

1. Launch the vLLM-only server with `gpu-memory-utilization=0.1`.
2. Run `benchmark.sh`.
3. Repeat with `gpu-memory-utilization=0.9`.
4. Enable MIG and create a 7g.80gb GPU Instance.
5. Launch the vLLM server on the GPU Instance with `gpu-memory-utilization=0.1`.
6. Run `benchmark.sh`.
7. Repeat with `gpu-memory-utilization=0.9`.

### Reproducing Fig. 2

1. Create one of the following MIG profiles:

   * 1g.10gb
   * 1g.20gb
   * 2g.20gb
   * 3g.40gb
   * 4g.40gb
   * 7g.80gb
2. Launch the vLLM server.
3. Execute `benchmark.sh`.
4. Repeat the measurement three times.
5. Plot the Output Token Throughput values.

### Expected Output

`vllm bench serve` reports Output Token Throughput and latency metrics. Example outputs are provided in `example_outputs/`.
