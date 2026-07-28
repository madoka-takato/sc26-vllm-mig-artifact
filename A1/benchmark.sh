#!/usr/bin/env bash

vllm bench serve \
  --base-url http://127.0.0.1:8000 \
  --model LiquidAI/LFM2.5-1.2B-Instruct \
  --tokenizer LiquidAI/LFM2.5-1.2B-Instruct \
  --backend vllm \
  --endpoint /v1/completions \
  --dataset-name sharegpt \
  --dataset-path /datasets/sharegpt/ShareGPT_V3_unfiltered_cleaned_split.json \
  --max-concurrency 256 \
  --request-rate 512 \
  --percentile-metrics ttft,tpot,itl,e2el \
  --num-prompts 3000
