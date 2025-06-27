.onLoad <- function(libname, pkgname) {
  suppressPackageStartupMessages({
    requireNamespace("ggplot2", quietly = TRUE)
    requireNamespace("tidymodels", quietly = TRUE)
  })
  
  packageStartupMessage(
    "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n",
    "🎉 Welcome to SenScoreR! 🎉\n",
    "This package calculates the senescence score (RSS) from gene expression data.\n",
    "Designed to explore cellular senescence-related transcriptional patterns.\n",
    "Author: Xin Gao (gaoxin_0612@163.com)\n",
    "🌐 GitHub: https://github.com/xingao0612/SenScoreR\n",
    "Version: ", packageVersion(pkgname), "\n\n",
    "📌 Quick Start Examples:\n",
    "    📈 Calculate RSS:\n",
    "        rss_scores <- calculate_rss(expr_matrix)\n",
    "    🧬 Correlate Genes with RSS:\n",
    "        gene_rss_cor <- correlate_with_rss(expr_matrix, rss_scores)\n",
    "    📊 Visualize RSS Distribution:\n",
    "        plot_rss_distribution(rss_scores, group_info)\n",
    "    💊 Predict ICI Resistance:\n",
    "        resistance_probs <- predict_ici_resistance(expr_matrix)\n\n",
    "🌟 Thank you for using SenScoreR! 🌟\n",
    "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n"
  )
}
