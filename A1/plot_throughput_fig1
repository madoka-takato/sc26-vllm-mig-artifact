import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Unit conversion: tokens/s -> k tokens/s
scale = 1000

# Load benchmark results
df = pd.read_excel("benchmark_results.xlsx")

fig, ax = plt.subplots(figsize=(10, 6))

configs = [
    ("vllm01", "vLLM-only, gpu-memory-utilization=0.1", "o"),
    ("vllm09", "vLLM-only, gpu-memory-utilization=0.9", "s"),
    ("mig01", "vLLM+MIG (7g.80gb), gpu-memory-utilization=0.1", "^"),
    ("mig09", "vLLM+MIG (7g.80gb), gpu-memory-utilization=0.9", "D"),
]

for column, label, marker in configs:
    ax.plot(
        df["num-of-measurements"],
        df[column] / scale,
        marker=marker,
        linestyle=":",
        markersize=10,
        label=label,
    )

ax.set_xlabel('Number of Measurements',  fontsize=14)
ax.set_ylabel("Output Token Throughput [k tokens/s]", fontsize=14)

ax.tick_params(axis="both", labelsize=12)

ax.set_xlim(0.5, 3.5)
ax.set_xticks(np.arange(1, 4, 1))
ax.set_ylim(0, 30)
ax.set_yticks(np.arange(0, 31, 5))

ax.grid(True, linestyle="-", alpha=0.5)

ax.legend(fontsize=10)

plt.tight_layout()

plt.savefig(
    "fig1_throughput_comparison.pdf",
    bbox_inches="tight"
)

plt.show()
