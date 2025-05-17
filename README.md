# SenScoreR
![](https://img.shields.io/badge/source%20code-support-blue) ![](https://img.shields.io/badge/R-package-green) ![](https://img.shields.io/badge/Version-0.1.1-yellow)<br>
**SenScoreR** is an R package for computing **senescence scores** from transcriptomic data using a curated set of Cellular Senescence-related genes.

> 🔬 Developed by **Xin Gao**, Department of Clinical Laboratory, Xiangya Hospital of Central South University  
> 📧 Contact: gaoxin_0612@163.com  
> 🌐 GitHub: https://github.com/xingao0612/SenScoreR  

---

## 🚀 Features

- Calculate a **senescence score** (range: 0–1) from gene expression data.
- Built-in Cellular Senescence-related gene sets (up-regulated & down-regulated).
- Easy to use with RNA-seq data.

---

## 📦 Installation

```r
# Install directly from GitHub
install.packages("devtools")  # if not yet installed
devtools::install_github("xingao0612/SenScoreR")
```

---

## 🧪 Quick Start Example

```r
# Load the package
library(SenScoreR)

# Simulate a gene expression matrix (rows = genes, columns = samples)
set.seed(123)
gene_names <- paste0("Gene", 1:1000)
sample_names <- paste0("Sample", 1:10)
expr_matrix <- matrix(rnorm(1000 * 10, mean = 5, sd = 2),
                      nrow = 1000, dimnames = list(gene_names, sample_names))

# Add some aging-related genes to the matrix
expr_matrix[c("CDKN2A", "TP53", "IL6", "GLB1", "SERPINE1"), 1:3] <- 
  expr_matrix[c("CDKN2A", "TP53", "IL6", "GLB1", "SERPINE1"), 1:3] + 3

# Calculate senescence scores
rss_scores <- calculate_rss(expr_matrix)

# View the result
print(rss_scores)
```

---

## 📊 Output

A named numeric vector giving senescence scores (between 0 and 1) for each sample.

```
Sample1 Sample2 Sample3 ... Sample10
 0.72     0.63     0.59       0.41
```

---

## 📁 Data Input Format

- The expression matrix should be a **TPM** numeric matrix (genes × samples).
- Row names must be **gene symbols** (e.g., "TP53", "CDKN2A").
- **Recommended usage for single-cell or spatial transcriptomics**:

  **Step 1**: Obtain single-cell object `sce` that has been normalized using Seurat v5 `NormalizeData()`.

  **Step 2**: Use the following R code to extract the expression matrix for input:

  ```r
  library(dplyr)

  geneSymbols <- sce[["RNA"]]@features %>% rownames()
  rownames(sce@assays$RNA@layers$data) <- geneSymbols

  cellNames <- sce[["RNA"]]@cells %>% rownames()
  colnames(sce@assays$RNA@layers$data) <- cellNames

  matrix <- as.matrix(sce@assays$RNA@layers$data)

  # Filter out genes with zero expression across all cells
  matrix <- matrix[rowSums(matrix) > 0, ]
  ```

---

## 🧬 Built-in Gene Sets

- `up_genes.rds`: genes up-regulated with aging.
- `down_genes.rds`: genes down-regulated with aging.

These are stored in `inst/extdata/` and automatically loaded by `calculate_rss()`.

---

## 📚 Citation & Acknowledgement

If you use this package in a publication, please cite:

> Gao, X. (2025). *SenScoreR: A Senescence Scoring Tool for Transcriptomic Analysis*. GitHub repository: https://github.com/xingao0612/SenScoreR

---

## 🛠️ Future Plans

- Web app interface via Shiny.

---

## 🙏 Thanks for using **SenScoreR**!

For questions or contributions, feel free to open an [Issue](https://github.com/xingao0612/SenScoreR/issues) or [Pull Request](https://github.com/xingao0612/SenScoreR/pulls).
