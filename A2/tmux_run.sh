#!/usr/bin/env bash
set -e

CONTAINERS=(1 2 3 4 5 6 7)

CONCURRENCY=256
REQUEST_RATE=512
NUM_PROMPTS=10000

SESSION="vllm_bench"
BENCH_SCRIPT="../run_bench.sh"
RESULT_DIR="./results"

mkdir -p ${RESULT_DIR}

tmux kill-session -t ${SESSION} 2>/dev/null || true

echo "Starting benchmark on servers: ${CONTAINERS[@]}"

FIRST=${CONTAINERS[0]}

tmux new-session -d \
  -s ${SESSION} \
  -n "c${FIRST}" \
  "bash ${BENCH_SCRIPT} ${FIRST} ${CONCURRENCY} ${REQUEST_RATE} ${NUM_PROMPTS}; read"

for i in "${CONTAINERS[@]:1}"; do
  tmux new-window \
    -t ${SESSION} \
    -n "c${i}" \
    "bash ${BENCH_SCRIPT} ${i} ${CONCURRENCY} ${REQUEST_RATE} ${NUM_PROMPTS}; read"
done

tmux attach -t ${SESSION}
