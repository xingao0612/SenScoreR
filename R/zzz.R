.onLoad <- function(libname, pkgname) {
  packageStartupMessage(
    "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n",
    "🎉 Welcome to SenScoreR! 🎉\n",
    "This package calculates the **senescence score** based on gene expression data.\n",
    "🔬 Designed to help you explore Cellular Senescence-related gene patterns.\n",
    "Author: Xin Gao (gaoxin_0612@163.com) 💌\n",
    "GitHub: https://github.com/xingao0612/SenScoreR\n",
    "Version: ", packageVersion(pkgname), "\n\n",
    "📌 To get started, simply run:\n",
    "    rss_scores <- calculate_rss(expr_matrix)\n\n",
    "🌟 Thank you for using SenScoreR! 🌟\n",
    "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n"
  )
}
