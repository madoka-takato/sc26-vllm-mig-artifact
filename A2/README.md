# A2/README.md

## A2: Multi-Server Comparison

### Purpose

This artifact reproduces the multi-server experiments presented in Figs. 5–8.

### Contents

* `launch_servers.sh` – launches up to seven vLLM servers.
* `benchmark.sh` – executes `vllm bench serve`.
* `tmux_run.sh` – executes benchmarks concurrently using tmux.
* `plot_throughput.py` — plots throughput results from benchmark results.
* `plot_latency.py` — plots latency metrics (TTFT, TPOT, ITL, and E2EL) from benchmark results.
* `example_outputs/` – example benchmark outputs.

### Prerequisites

Identical to A1.

### Reproducing Figs. 5–7

1. Configure the target environment:

   * *vLLM-only*, or
   * *vLLM+MIG*.

2. Launch seven vLLM servers.

3. Run benchmarks concurrently on seven, six, five, ..., and one selected
   servers using `tmux_run.sh`.

### Reproducing Fig. 8

1. Launch seven servers.
2. Execute the Level-2 workload.
3. Repeat the seven-server experiment without restarting the servers.

### Expected Output

Each benchmark produces per-server throughput and latency metrics (TTFT, TPOT, ITL, and E2EL). 
The values are summarized in an Excel file and plotted using the
provided `plot_throughput.py` and `plot_latency.py` scripts to reproduce Figs. 5–8.
Example outputs are provided in `example_outputs/`.
