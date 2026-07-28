#!/usr/bin/env bash

docker run \
    --name vllm_bench_server \
    --gpus all \
    -p 8001:8000 \
    -v ~/.cache/huggingface:/root/.cache/huggingface \
    --env "HUGGING_FACE_HUB_TOKEN" \
    --ipc=host \
    vllm/vllm-openai:v0.19.0 \
      --model LiquidAI/LFM2.5-1.2B-Instruct \
      --gpu-memory-utilization 0.9 \
      --max-num-seqs 256 \
      --max-num-batched-tokens 4096 \
      --port 8000
