import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Load latency results
df = pd.read_excel("latency_results.xlsx")

fig, ax1 = plt.subplots(figsize=(10, 6))

x = np.arange(len(df["servers"]))
w = 0.25

# ms -> s conversion
ms_to_s = 1000

# TTFT / TPOT / ITL
ax1.bar(
    x - w,
    df["ttft"] / ms_to_s,
    width=w,
    color="#C0392B",
    label="TTFT",
    edgecolor="white",
    linewidth=0.5,
)

ax1.bar(
    x,
    df["tpot"] / ms_to_s,
    width=w,
    color="#E57368",
    label="TPOT",
    edgecolor="white",
    linewidth=0.5,
)

ax1.bar(
    x + w,
    df["itl"] / ms_to_s,
    width=w,
    color="#F1AFA8",
    label="ITL",
    edgecolor="white",
    linewidth=0.5,
)


ax1.set_title("Latency Breakdown", fontsize=20)
ax1.set_xlabel("# of Concurrent vLLM Servers", fontsize=16)
ax1.set_ylabel("TTFT / TPOT / ITL [s]", fontsize=16)

ax1.set_xticks(x)
ax1.set_xticklabels(df["servers"])

ax1.tick_params(axis="both", labelsize=14)

ax1.grid(True, linestyle="-", alpha=0.3)
ax1.set_axisbelow(True)

ax1.set_ylim(0, 10)


# E2EL
ax2 = ax1.twinx()

ax2.scatter(
    x,
    df["e2el"] / ms_to_s,
    color="#27AE60",
    marker="o",
    s=120,
    edgecolor="white",
    linewidth=1.0,
    label="E2EL",
    zorder=5,
)

ax2.set_ylabel("E2EL [s]", fontsize=16)
ax2.tick_params(axis="y", labelsize=14)

ax2.set_ylim(0, 50)


# Combined legend
handles1, labels1 = ax1.get_legend_handles_labels()
handles2, labels2 = ax2.get_legend_handles_labels()

ax1.legend(
    handles1 + handles2,
    labels1 + labels2,
    fontsize=12,
)


plt.tight_layout()

plt.savefig(
    "latency_breakdown.pdf",
    bbox_inches="tight",
)

plt.show()
