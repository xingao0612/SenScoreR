#' Plot RSS Distribution per Sample
#'
#' This function generates a bar plot showing the RSS score distribution across all samples.
#'
#' @param result_df A data frame containing "Sample" and "RSS" columns (output of calculate_rss()).
#'
#' @return A ggplot2 object.
#' @export
#' @import ggplot2

plot_rss_distribution <- function(result_df) {
  if (!all(c("Sample", "RSS") %in% colnames(result_df))) {
    stop("Input data frame must contain 'Sample' and 'RSS' columns.")
  }
  
  result_df <- result_df[order(-result_df$RSS), ]
  result_df$Sample <- factor(result_df$Sample, levels = result_df$Sample)
  
  p <- ggplot(result_df, aes(x = Sample, y = RSS, fill = RSS)) +
    geom_col() +
    scale_fill_gradient(low = "#00c6ff", high = "#D1352C") +
    theme_minimal(base_size = 15) +
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 1)) +
    labs(title = "RSS per Sample", x = "Sample", y = "RSS", fill = "RSS")
  
  return(p)
}
