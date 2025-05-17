#' Calculate Rank-based Senescence Score (RSS)
#'
#' This function calculates a rank-based senescence score (RSS) for each sample based on the
#' expression levels of up-regulated and down-regulated senescence-related genes.
#'
#' @param expr_matrix A matrix of gene expression data (rows are genes, columns are samples).
#' @param up_genes_file A file path to the up-regulated senescence genes (rds format). Default is NULL, which uses built-in genes.
#' @param down_genes_file A file path to the down-regulated senescence genes (rds format). Default is NULL, which uses built-in genes.
#' 
#' @return A data frame with sample names and corresponding normalized RSS values.
#' @export
calculate_rss <- function(expr_matrix, up_genes_file = NULL, down_genes_file = NULL) {
  
  # ✅ Check input type
  if (!is.matrix(expr_matrix)) {
    stop("❌ Input data must be a matrix. Please convert your expression data to matrix format using as.matrix().")
  }
  
  # Load default genes if no file provided
  if (is.null(up_genes_file)) {
    up_genes <- readRDS(system.file("extdata", "up_genes.rds", package = "SenScoreR"))
  } else {
    up_genes <- readRDS(up_genes_file)
  }
  
  if (is.null(down_genes_file)) {
    down_genes <- readRDS(system.file("extdata", "down_genes.rds", package = "SenScoreR"))
  } else {
    down_genes <- readRDS(down_genes_file)
  }
  
  # Ensure the genes are in the expression matrix
  up_genes <- intersect(up_genes, rownames(expr_matrix))
  down_genes <- intersect(down_genes, rownames(expr_matrix))
  
  # Check if we have enough genes
  if (length(up_genes) < 5 || length(down_genes) < 5) {
    stop("❌ Too few valid up/down genes in the expression matrix.")
  }
  
  # Print the genes being used
  message(paste0("✅ Using ", length(up_genes), " up-regulated and ", 
                 length(down_genes), " down-regulated senescence genes."))
  
  # Define the rank enrichment function
  rank_enrichment <- function(ranked_genes, target_genes) {
    hits <- which(ranked_genes %in% target_genes)
    score <- sum((length(ranked_genes) - hits + 1) / length(ranked_genes))
    return(score / length(target_genes))
  }
  
  # Calculate raw RSS scores for each sample
  n_samples <- ncol(expr_matrix)
  raw_scores <- numeric(n_samples)
  
  # Create a progress bar
  pb <- txtProgressBar(min = 0, max = n_samples, style = 3)
  for (i in 1:n_samples) {
    sample_expr <- expr_matrix[, i]
    ranked_genes <- names(sort(sample_expr, decreasing = TRUE))
    
    # Calculate enrichment scores
    up_score <- rank_enrichment(ranked_genes, up_genes)
    down_score <- rank_enrichment(rev(ranked_genes), down_genes)
    
    # Aggregate the scores
    raw_scores[i] <- up_score + down_score
    
    # Update progress bar
    setTxtProgressBar(pb, i)
  }
  close(pb)
  
  # Normalize scores to [0, 1]
  norm_scores <- (raw_scores - min(raw_scores)) / (max(raw_scores) - min(raw_scores))
  
  # Return the result as a data frame
  result_df <- data.frame(
    Sample = colnames(expr_matrix),
    RSS = round(norm_scores, 4),
    stringsAsFactors = FALSE
  )
  
  message("✅ RSS calculation completed.")
  return(result_df)
}
