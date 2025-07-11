#!/bin/bash
set -euo pipefail

# Load helper functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/setup.sh"

setup_uv

setup_huggingface

setup_dummy_openai_api_key

CUDA_VISIBLE_DEVICES=0,1 uv run python scripts/vf_vllm_spawn.py \
  --model 'ljt019/Qwen3-1.7B-Battleship-SFT' \
  --port 8000 \
  --host 127.0.0.1 \
  --max-model-len 22498 \
  --tensor-parallel-size 2 \
  --gpu-memory-utilization 0.2
