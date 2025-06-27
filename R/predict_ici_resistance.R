#' Predict ICI Resistance Using Trained LightGBM Model
#'
#' This function applies a trained LightGBM workflow model to user expression data
#' to predict the probability of immune checkpoint inhibitor (ICI) resistance.
#'
#' @param expr_matrix A gene expression matrix (genes in rows, samples in columns).
#'
#' @return A data frame containing sample IDs and predicted probabilities.
#' @export
#' @import tidymodels

predict_ici_resistance <- function(expr_matrix) {
  if (!is.matrix(expr_matrix)) stop("Expression matrix must be a matrix.")
  
  # Load built-in model and gene list from extdata
  model_path <- system.file("extdata", "evalresult_lightgbm.RData", package = "SenScoreR")
  gene_path <- system.file("extdata", "model.genes.rds", package = "SenScoreR")
  
  if (model_path == "" || gene_path == "") {
    stop("❌ Required model files not found in package extdata.")
  }
  
  load(model_path)  # loads `final_lightgbm`
  model_genes <- readRDS(gene_path)
  
  # Transpose and match gene order
  new_data <- as.data.frame(t(expr_matrix))
  
  missing_genes <- setdiff(model_genes, colnames(new_data))
  if (length(missing_genes) > 0) {
    warning("⚠️ Resistance prediction skipped due to missing genes: ", paste(missing_genes, collapse = ", "))
    return(NULL)
  }
  
  new_data <- new_data[, model_genes, drop = FALSE]
  pred_probs <- predict(final_lightgbm, new_data = new_data, type = "prob")
  
  prob_col <- if ("`.pred_1`" %in% colnames(pred_probs)) ".pred_1" else colnames(pred_probs)[1]
  
  data.frame(
    Sample = rownames(new_data),
    Resistance_Prob = round(pred_probs[[prob_col]], 4),
    stringsAsFactors = FALSE
  )
}
