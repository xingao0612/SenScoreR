#' Calculate Gene-RSS Correlation
#'
#' This function computes the Pearson correlation between each gene and the RSS score across samples.
#'
#' @param expr_matrix A gene expression matrix (genes x samples).
#' @param result_df A data frame containing "Sample" and "RSS" columns (output of calculate_rss()).
#'
#' @return A data frame with gene-wise correlation statistics.
#' @export
gene_rss_correlation <- function(expr_matrix, result_df) {
  if (!is.matrix(expr_matrix)) stop("Expression matrix must be a matrix.")
  if (!all(colnames(expr_matrix) %in% result_df$Sample)) stop("Sample names in RSS do not match expression matrix.")
  
  rss_vec <- result_df$RSS[match(colnames(expr_matrix), result_df$Sample)]
  cor_vec <- apply(expr_matrix, 1, function(x) cor(x, rss_vec, method = "pearson"))
  
  # Parallel p-value calculation
  cl <- parallel::makeCluster(parallel::detectCores(logical = FALSE) - 1)
  parallel::clusterExport(cl, c("expr_matrix", "rss_vec"), envir = environment())
  pvals <- parallel::parLapply(cl, seq_len(nrow(expr_matrix)), function(i) {
    cor.test(expr_matrix[i, ], rss_vec)$p.value
  })
  parallel::stopCluster(cl)
  
  data.frame(
    Gene = rownames(expr_matrix),
    Correlation = cor_vec,
    P.Value = unlist(pvals),
    Adj.P.Value = p.adjust(unlist(pvals), method = "BH"),
    stringsAsFactors = FALSE
  )
}
