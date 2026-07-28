#!/usr/bin/env bash
set -e

MODEL="LiquidAI/LFM2.5-1.2B-Instruct"
NUM_CONTAINERS=7

echo "=== Starting vLLM servers sequentially ==="

for i in $(seq 1 ${NUM_CONTAINERS}); do
  PORT=$((8000 + i))

  echo "Starting container ${i} (port: ${PORT})..."

  docker run -d \
    --name vllm_bench_server_${i} \
    --gpus all \
    -p ${PORT}:8000 \
    -v ~/.cache/huggingface:/root/.cache/huggingface \
    --env "HUGGING_FACE_HUB_TOKEN" \
    --ipc=host \
    vllm/vllm-openai:v0.19.0 \
      --model ${MODEL} \
      --gpu-memory-utilization 0.108 \
      --max-num-seqs 256 \
      --max-num-batched-tokens 4096 \
      --port 8000

  echo -n "Waiting for container ${i} to become ready..."

  until curl -sf http://127.0.0.1:${PORT}/health > /dev/null 2>&1; do
    sleep 5
    echo -n "."
  done

  echo " OK"
done

echo ""
echo "=== All vLLM servers are ready ==="
