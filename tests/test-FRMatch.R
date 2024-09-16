install.packages("testthat", repos='http://cran.us.r-project.org')
install.packages("data.table", repos='http://cran.us.r-project.org')
library(testthat)
library(FRmatch)
library(SingleCellExperiment)
library(dplyr)
library(tibble)
library(data.table)

## Load example object
data(sce.example)
## Rename the example object
sce.layer1 <- sce.example

## Read in pieces of input data - this may take a few minutes
cell_by_gene_expression <- fread("tests/test_data/cell_by_gene_expression.csv")
cell_cluster_labels <- fread("tests/test_data/cell_cluster_labels.csv")
NSForest_marker_genes <- fread("tests/test_data/NSForest_marker_genes.csv")
NSForest_fscores <- fread("tests/test_data/NSForest_fscores.csv")
MTG_taxonomy <- fread("tests/test_data/MTG_taxonomy.csv")$x ## Needs to be a vector

## Unique markers
unique_markers <- unique(NSForest_marker_genes$markerGene)

## Create data object
sce.MTG <- make_data_object(dat = cell_by_gene_expression,
                            tab = cell_cluster_labels,
                            markers = unique_markers,
                            ## Below are optional input data
                            cluster_marker_info = NSForest_marker_genes,
                            f_score = NSForest_fscores,
                            cluster_order = MTG_taxonomy)

## Run FRMatch
rst.layer1toMTG <- FRmatch(sce.query = sce.layer1, sce.ref = sce.MTG, subsamp.size = 10)

## Read expected results
expected_results <- readRDS("/root/tests/test_data/expected_results")

test_that(desc = "FRMatch outputs expected results", code = {
  ## Test that the result is the correct value
  expect_equal(rst.layer1toMTG, expected_results);
})