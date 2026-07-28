import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Unit conversion: tokens/s -> k tokens/s
scale = 1000

# Load benchmark results
df = pd.read_excel("benchmark_results.xlsx")

fig, ax = plt.subplots(figsize=(10, 6))

mig_profiles = [
    "1g.10gb",
    "1g.20gb",
    "2g.20gb",
    "3g.40gb",
    "4g.40gb",
    "7g.80gb",
]

markers = ["o", "s", "^", "D", "v", "P"]

for profile, marker in zip(mig_profiles, markers):
    ax.plot(
        df["num-of-measurements"],
        df[profile] / scale,
        marker=marker,
        linestyle=":",
        markersize=10,
        label=profile,
    )

ax.set_xlabel('Number of Measurements',  fontsize=14)
ax.set_ylabel("Output Token Throughput [k tokens/s]", fontsize=14)

ax.tick_params(axis="both", labelsize=12)

ax.set_xlim(0.5, 3.5)
ax.set_xticks(np.arange(1, 4, 1))

ax.grid(True, linestyle="-", alpha=0.5)

ax.legend(fontsize=11)

plt.tight_layout()
plt.savefig("throughput_mig_profiles.pdf", bbox_inches="tight")
plt.show()
