import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Convert tokens/s to k tokens/s
scale = 1000

# Load benchmark results
df = pd.read_excel("throughput_results.xlsx")

fig, ax = plt.subplots(figsize=(8, 5))

x = np.arange(len(df["parallels"]))
width = 0.25

metrics = [
    ("throughput_mean", "Mean", "MEAN"),
    ("throughput_max", "Maximum", "MAX"),
    ("throughput_sum", "Total", "SUM"),
]

for offset, (column, label, _) in zip([-width, 0, width], metrics):
    ax.bar(
        x + offset,
        df[column] / scale,
        width=width,
        label=label,
    )

ax.set_xlabel("# of Concurrent vLLM Servers")
ax.set_ylabel("Throughput [k tokens/s]")

ax.set_xticks(x)
ax.set_xticklabels(df["parallels"])

ax.set_ylim(0, 40)

ax.grid(True, linestyle="-", alpha=0.3)
ax.set_axisbelow(True)

ax.legend()

plt.tight_layout()

plt.savefig(
    "throughput_comparison.pdf",
    bbox_inches="tight"
)

plt.show()
