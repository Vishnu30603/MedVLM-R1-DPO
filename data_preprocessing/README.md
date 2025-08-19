# Data Preprocessing

This folder contains scripts and notebooks to prepare the datasets used for **Supervised Fine-Tuning (SFT)** and **Direct Preference Optimization (DPO)** training.

---

##  Overview

1. **Input**  
   - CSVs produced in [`dataset_preparation/data_to_csv.ipynb`](../dataset_preparation/).  
   - These CSVs contain medical VQA samples (image paths, questions, answer options, ground truth).

2. **Chain-of-Thought (CoT) Generation**  
   - Using **MedVLM-R1 checkpoint**, CoTs are generated for each sample.  
   - Saved as new CSVs with an additional column: `medvlm_r1_cot`.

3. **Final Conversion to JSONL**  
   - **`csv_to_jsonl.ipynb`** script processes the CSVs:  
     - Filters samples where MedVLM-R1’s prediction matches the ground truth.  
     - Builds **SFT JSONL**: generic reasoning outputs.  
     - Builds **DPO JSONL**: pairs with CoT as *chosen* and generic output as *rejected*.
     - **All generated JSONL files are saved in the [`/data`](../data/) folder** of the repository.
       
---

##  Processing Pipeline

1. **Filter for Correct Predictions**  
   - Only keep samples where `<answer>` in `medvlm_r1_cot` matches the ground truth.

2. **Sampling Strategy**  
   - Train: 1100 samples  
   - Test MRI: 150 samples  
   - Test CT: 150 samples  
   - Test X-Ray: 150 samples  

3. **SFT Dataset Creation**  
   Each entry has:
   ```json
   {
     "instruction": "You are a medical assistant. Answer based on the image and question.",
     "input": "<question + options + reasoning instructions>",
     "output": "<think>...generic reasoning...</think>\n<answer>X</answer>",
     "images": ["/path/to/image.png"]
   }

 4. **DPO Dataset Creation**
    Each entry has:
    ```json
   {
     "prompt": "<image>\n<question + options + reasoning instructions>",
     "image_path": "/path/to/image.png",
     "chosen": "<CoT reasoning with correct <answer>>",
     "rejected": "<Generic short reasoning + correct <answer>>"
   }
