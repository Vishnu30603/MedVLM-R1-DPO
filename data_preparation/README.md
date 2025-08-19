# Dataset Preparation

## Step 1: Download the OmniMedVQA dataset

Please first download the **OmniMedVQA** dataset from Hugging Face:

👉 [https://huggingface.co/datasets/foreverbeliever/OmniMedVQA](https://huggingface.co/datasets/foreverbeliever/OmniMedVQA)

This dataset contains a large-scale medical Visual Question Answering benchmark with **118,010 images** and **127,995 QA-items**, spanning **12 medical image modalities** and over **20 anatomical regions**.

---

## Step 2: Preprocessing with `data_to_csv.ipynb`

This notebook processes OmniMedVQA to produce a clean, filtered subset for training and evaluation.

### Processing Steps

1. **Load Metadata**  
   - Reads all JSON QA files from `OmniMedVQA/QA_information/Open-access/`.  
   - Converts them into a pandas DataFrame.

2. **Filter for Image Quality**  
   - Removes images smaller than 128 px.  
   - Removes low-variance (blurry or blank) images.

3. **Filter for Meaningful QA Pairs**  
   - Keeps only pairs where:  
     - Question length ≥ 10 characters  
     - Answer length ≥ 1 character  
     - Answer not in {`unclear`, `unknown`, `no finding`, `none`}

4. **Modality Selection**  
   - Retains only **MRI, CT, and X-Ray**.  
   - Excludes OCT scans.

5. **Train / Validation / Test Splits**  
   - **MRI (RadImageNet):** up to 2000 train, 300 validation, 300 test samples.  
   - **CT:** up to 300 samples for test.  
   - **X-Ray:** up to 300 samples for test.  

6. **Save Output CSVs**  
   - Generates:  
     - `train.csv`  
     - `val.csv`  
     - `test_mri.csv`  
     - `test_ct.csv`  
     - `test_xray.csv`

7. **Copy Required Images**  
   - Copies images into `OmniMedVQA_Subset_MedVLMR1/`, preserving folder structure.

8. **Sanity Check**  
   - Verifies that all images referenced in the CSV files exist in the subset directory.

---

