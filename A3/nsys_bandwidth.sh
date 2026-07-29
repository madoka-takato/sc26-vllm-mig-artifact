#!/bin/bash
set -e

MODEL="LiquidAI/LFM2.5-1.2B-Instruct"
OUTPUT_NAME=${1:-nsys_profile}

nsys profile \
  -o ${OUTPUT_NAME} \
  --trace-fork-before-exec=true \
  --cuda-graph-trace=node \
  --gpu-metrics-devices=1 \
  --trace=cuda,nvtx,osrt,cudnn \
  python3 -m vllm.entrypoints.openai.api_server \
    --model ${MODEL} \
    --gpu-memory-utilization 0.90 \
    --max-num-seqs 256 \
    --max-num-batched-tokens 4096 \
    --port 8000
