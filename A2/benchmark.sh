#!/usr/bin/env bash

SERVER_ID=$1
CONCURRENCY=$2
REQUEST_RATE=$3
NUM_PROMPTS=$4

PORT=$((8000 + SERVER_ID))

MODEL="LiquidAI/LFM2.5-1.2B-Instruct"
RESULT_DIR=./results

mkdir -p ${RESULT_DIR}

echo "=== Starting benchmark on server ${SERVER_ID} ===" | tee ${RESULT_DIR}/server${SERVER_ID}.log
echo "port=${PORT} concurrency=${CONCURRENCY} request_rate=${REQUEST_RATE}" \
  | tee -a ${RESULT_DIR}/server${SERVER_ID}.log

docker exec vllm_bench_server_${SERVER_ID} \
    vllm bench serve \
    --base-url http://127.0.0.1:8000 \
    --model "${MODEL}" \
    --tokenizer "${MODEL}" \
    --backend vllm \
    --endpoint /v1/completions \
    --dataset-name sharegpt \
    --dataset-path /datasets/sharegpt/ShareGPT_V3_unfiltered_cleaned_split.json \
    --max-concurrency "${CONCURRENCY}" \
    --request-rate "${REQUEST_RATE}" \
    --percentile-metrics ttft,tpot,itl,e2el \
    --num-prompts "${NUM_PROMPTS}" \
    --save-result \
    --save-detailed \
    --result-filename ${RESULT_DIR}/server${SERVER_ID}_result.json \
    --temperature 0 \
  2>&1 | tee -a ${RESULT_DIR}/server${SERVER_ID}.log

echo "=== Benchmark completed on server ${SERVER_ID} ===" \
  | tee -a ${RESULT_DIR}/server${SERVER_ID}.log
