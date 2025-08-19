# Evaluation Notebooks

This folder contains Jupyter notebooks for evaluating model performance across different test sets and baselines.

## Contents
- `evaluation_150.ipynb`  
  - Evaluation on **150 test samples per modality** (MRI, CT, X-ray)  
  - Includes baseline comparison against **MedVLM-R1**  

- `evaluation_300.ipynb`  
  - Evaluation on **300 test samples per modality** (MRI, CT, X-ray)  

- `evaluation_medvlm_r1.ipynb`  
  - Evaluation of the **original MedVLM-R1 model**  
  - Uses the **same 300 per-modality test samples** as in `evaluation_300.ipynb` for direct comparison  

- `evaluation_zeroshot.ipynb`  
  - **Zero-shot evaluation** of the base model (Qwen2-VL-2B-Instruct)  
  - No fine-tuning applied — serves as a baseline reference  
