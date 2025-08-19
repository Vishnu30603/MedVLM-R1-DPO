# Training Scripts

This folder contains lightweight shell scripts to reproduce the training pipeline used in this project.  
They are simple wrappers around **LLaMA-Factory** CLI commands — you can either run them directly or copy the commands into your own workflow.

## Usage
```bash
bash scripts/sft_train.sh   # Run SFT training
bash scripts/dpo_train.sh   # Run DPO training
