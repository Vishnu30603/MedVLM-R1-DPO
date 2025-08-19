# DPO for Medical VLMs: Efficient Chain-of-Thought Learning and Out-of-Domain Generalization

This repository contains the code, datasets, and models for my **Summer Research Internship Project**:  
**“DPO for Medical VLMs: Efficient Chain-of-Thought Learning and Out-of-Domain Generalization”**  
carried out at **Deakin University, Australia** (Summer 2025).

We replicate and extend the **MedVLM-R1** pipeline, introducing an efficient **Supervised Fine-Tuning (SFT) + Direct Preference Optimization (DPO)** alignment strategy that achieves state-of-the-art reasoning quality and generalization with drastically reduced training cost.

---

## Abstract

Large Vision-Language Models (VLMs) perform strongly on medical Visual Question Answering (MedVQA) but often fail to generalize reasoning to unseen modalities such as CT and X-ray.  

In this project, we fine-tuned **Qwen2-VL-2B-Instruct** using:
- **Supervised Fine-Tuning (SFT)** on MRI data to establish generic reasoning.
- **Direct Preference Optimization (DPO)** with **MedVLM-R1-generated CoTs** as *chosen* responses and SFT-style generic answers as *rejected*.  

This lightweight alignment pipeline matches **MedVLM-R1 accuracy** (99.3% MRI, 91.3% CT/X-ray) while reducing training time by **~26× (9 min vs. 4 hours on 2×A100 GPUs)**.

---

## Key Results

| Model             | MRI (%) | CT (%) | X-ray (%) |
|-------------------|---------|--------|-----------|
| Zero-shot (Base)  | 32.00   | 34.67  | 37.33     |
| SFT (5 epochs)    | 98.00   | 74.00  | 84.00     |
| SFT + DPO (5 ep.) | **99.33** | **91.33** | **91.33** |

- Matches **MedVLM-R1** performance on 300-sample benchmark tests.
- Achieves strong **reasoning interpretability** through reliable CoT outputs.
- Reduces training runtime by **26×** compared to GRPO-based MedVLM-R1.

---

## Pipeline

1. **Dataset Preparation**  
   - Download [OmniMedVQA](https://huggingface.co/datasets/foreverbeliever/OmniMedVQA).  
   - Use [`dataset_preparation/data_to_csv.ipynb`](dataset_preparation/data_to_csv.ipynb) to filter clean MRI/CT/X-ray samples and generate CSV splits.  

2. **CoT Generation**  
   - Run `cot_generation_using_medvlm_r1.ipynb` to generate Chain-of-Thought reasoning using the **MedVLM-R1 checkpoint**.  

3. **Data Preprocessing**  
   - Convert CSVs to JSONL for SFT/DPO using [`data_preprocessing/csv_to_jsonl.py`](data_preprocessing/csv_to_jsonl.py).  
   - **All final JSONL datasets are stored in the [`/data`](data/) folder.**

   - **SFT JSONL format**:
     ```json
     {
       "instruction": "You are a medical assistant. Answer based on the image and question.",
       "input": "<question + options + reasoning instructions>",
       "output": "<think>...generic reasoning...</think>\n<answer>X</answer>",
       "images": ["/path/to/image.png"]
     }
     ```

   - **DPO JSONL format**:
     ```json
     {
       "prompt": "<image>\n<question + options + reasoning instructions>",
       "image_path": "/path/to/image.png",
       "chosen": "<CoT reasoning with correct <answer>>",
       "rejected": "<Generic short reasoning + correct <answer>>"
     }
     ```

4. **Training**  
   - Run lightweight shell scripts in [`scripts/`](scripts/):
     ```bash
     bash scripts/sft_train.sh   # Supervised Fine-Tuning
     bash scripts/dpo_train.sh   # Direct Preference Optimization
     ```

   - Checkpoints are stored in [`checkpoints/`](checkpoints/) (final SFT + DPO models).  

5. **Evaluation**  
   - Use [`notebooks/evaluation.ipynb`](notebooks/evaluation.ipynb) to compare SFT vs. DPO vs. MedVLM-R1.  
   - Run [`notebooks/medvlm_r1_inference.ipynb`](notebooks/medvlm_r1_inference.ipynb) for direct benchmarking.  

---

