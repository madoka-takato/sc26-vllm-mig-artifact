# A2/README.md

## A2: Multi-Server Comparison

### Purpose

This artifact reproduces the multi-server experiments presented in Figs. 3–6.

### Contents

* `launch_servers.sh` – launches up to seven vLLM servers.
* `benchmark.sh` – executes `vllm bench serve`.
* `tmux_run.sh` – executes benchmarks concurrently using tmux.
* `example_outputs/` – example benchmark outputs.

### Prerequisites

Identical to A1.

### Reproducing Figs. 3–5

1. Configure either:

   * vLLM-only, or
   * vLLM+MIG.
2. Launch seven vLLM servers.
3. Execute `tmux_run.sh`.
4. Repeat the benchmark while targeting seven, six, five, ..., and one server.
5. Repeat each experiment three times.

### Reproducing Fig. 6

1. Launch seven servers.
2. Execute the Level-2 workload.
3. Repeat the seven-server experiment without restarting the servers.

### Expected Output

Each benchmark produces per-server throughput and latency metrics (TTFT, TPOT, ITL, and E2EL). Example outputs are provided in `example_outputs/`.
