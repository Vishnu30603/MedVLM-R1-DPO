#!/bin/bash
# SFT Training Script using LLaMA-Factory
# Usage: bash scripts/sft_train.sh

# Paths (CHANGE these according to your setup)
DATA_DIR="data"
OUTPUT_DIR="saves/Qwen2-VL-2B-Instruct/lora/sft"

# Run training
llamafactory-cli train \
    --stage sft \
    --do_train True \
    --model_name_or_path Qwen/Qwen2-VL-2B-Instruct \
    --preprocessing_num_workers 16 \
    --finetuning_type lora \
    --template qwen2_vl \
    --flash_attn auto \
    --dataset_dir $DATA_DIR \
    --dataset medvqa_train \
    --cutoff_len 2048 \
    --learning_rate 2e-05 \
    --num_train_epochs 5.0 \
    --max_samples 100000 \
    --per_device_train_batch_size 4 \
    --gradient_accumulation_steps 1 \
    --lr_scheduler_type cosine \
    --max_grad_norm 1.0 \
    --logging_steps 5 \
    --save_steps 100 \
    --warmup_ratio 0.05 \
    --packing False \
    --enable_thinking True \
    --report_to none \
    --output_dir $OUTPUT_DIR \
    --bf16 True \
    --plot_loss True \
    --trust_remote_code True \
    --ddp_timeout 180000000 \
    --include_num_input_tokens_seen True \
    --optim adamw_torch \
    --lora_rank 16 \
    --lora_alpha 32 \
    --lora_dropout 0.1 \
    --lora_target all \
    --freeze_vision_tower True \
    --freeze_multi_modal_projector True \
    --image_max_pixels 589824 \
    --image_min_pixels 1024 \
    --video_max_pixels 65536 \
    --video_min_pixels 256 \
    --val_size 0.0901 \
    --eval_strategy steps \
    --eval_steps 50 \
    --per_device_eval_batch_size 2
