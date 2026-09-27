# SenScoreR
![](https://img.shields.io/badge/source%20code-support-blue) ![](https://img.shields.io/badge/R-package-green) ![](https://img.shields.io/badge/Version-0.1.2-yellow)<br>
**SenScoreR** is an R package for computing **senescence scores** from transcriptomic data using a curated set of Cellular Senescence-related genes.  
It also supports **ICI resistance prediction** and **senescence score visualization**.

---

## 🚀 Features

- Calculate **Rank-based Senescence Score (RSS)** from gene expression data.
- Built-in curated **Cellular Senescence-related gene sets** (up-regulated & down-regulated).
- Predict **Immune Checkpoint Inhibitor (ICI) resistance** using transcriptome.
- Visualize **RSS score distributions and gene-RSS correlations**.
- Shiny app and programmatic usage both supported.

---
## 📦 Dependencies

SenScoreR depends on the following R packages:

- **ggplot2** – for visualization
- **tidymodels** – for ICI resistance modeling and prediction

These packages will be automatically loaded, but make sure they are installed on your system.

---

## 📦 Installation

```r
# Install directly from GitHub
install.packages("devtools")  # if not yet installed
devtools::install_github("xingao0612/SenScoreR")
```

---

## 🧪 Quick Start: Calculate RSS

```r
library(SenScoreR)

# Simulated gene expression matrix
set.seed(123)
gene_names <- paste0("Gene", 1:1000)
sample_names <- paste0("Sample", 1:10)
expr_matrix <- matrix(rnorm(1000 * 10, mean = 5, sd = 2),
                      nrow = 1000, dimnames = list(gene_names, sample_names))

# Spike in Cellular Senescence-related genes
expr_matrix[c("CDKN2A", "TP53", "IL6", "GLB1", "SERPINE1"), 1:3] <- 
  expr_matrix[c("CDKN2A", "TP53", "IL6", "GLB1", "SERPINE1"), 1:3] + 3

# Calculate RSS
rss_scores <- calculate_rss(expr_matrix)
print(rss_scores)
```

---

## 📈 Feature 1: Visualize RSS and Correlations

```r
# Visualize RSS distribution
plot_rss_distribution(rss_scores)

# Visualize correlation between gene expression and RSS
plot_gene_rss_correlation(expr_matrix, rss_scores)
```

---

## 📈 Feature 2: Predict ICI Resistance

```r
# Predict ICI resistance
result <- predict_ici_resistance(expr_matrix)
head(result)
```

**Output**: A `data.frame` with columns `Sample`, `ICI_Resistance_Probability`, and `ICI_Resistance_Class`.

---

## 📁 Data Input Format

- Expression matrix: numeric matrix (genes × samples).
- Row names must be **HGNC gene symbols** (e.g., "TP53").
- TPM/FPKM or log-normalized counts recommended.

---

## 🧠 Behind the Scenes

- **RSS** is rank-based and normalized between 0 and 1.
- **ICI resistance prediction** uses a LightGBM model trained on public ICI datasets.

---

## 📚 Citation & Acknowledgement

If you use **SenScoreR** in your research, please cite the following paper:

> Gao, X., Zhou, XJ. **Clinical translation of senescence-related pan-cancer multi-omics: tools for assessment and immunotherapy prediction.** *Cancer Gene Ther* (2026).
> https://doi.org/10.1038/s41417-026-01080-1

A BibTeX entry for convenience:

```bibtex
@article{Gao2026SenScoreR,
  author  = {Gao, Xin and Zhou, Xiao-Jun},
  title   = {Clinical translation of senescence-related pan-cancer multi-omics: tools for assessment and immunotherapy prediction},
  journal = {Cancer Gene Therapy},
  year    = {2026},
  doi     = {10.1038/s41417-026-01080-1},
  url     = {https://doi.org/10.1038/s41417-026-01080-1}
}
```

**Source code & issue tracker:** https://github.com/xingao0612/SenScoreR

We thank all users and contributors who have helped improve **SenScoreR**. Bug reports, feature requests, and pull requests are warmly welcomed at the GitHub repository above.

---

## 🌐 Web App Interface

Run the package via web:

> 🧪 **Try it now**: https://gxhub.shinyapps.io/SenScoreR/

Functions available:

- Upload expression matrix.
- View RSS and visualizations.
- Predict ICI resistance with downloadable results.

---

## 🙏 Thanks for using **SenScoreR**!

For questions or contributions, open an [Issue](https://github.com/xingao0612/SenScoreR/issues) or [Pull Request](https://github.com/xingao0612/SenScoreR/pulls).
