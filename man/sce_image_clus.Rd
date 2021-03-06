% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sce_image_clus.R
\name{sce_image_clus}
\alias{sce_image_clus}
\title{Sample spatial cluster visualization}
\usage{
sce_image_clus(
  sce,
  sampleid,
  clustervar,
  colors = c("#b2df8a", "#e41a1c", "#377eb8", "#4daf4a", "#ff7f00", "gold", "#a65628",
    "#999999", "black", "grey", "white", "purple"),
  spatial = TRUE,
  ...
)
}
\arguments{
\item{sce}{Defaults to the output of
\code{fetch_data(type = 'sce')}. This is a
\linkS4class{SingleCellExperiment}
object with the spot-level Visium data and information required for
visualizing the histology. See \code{\link[=fetch_data]{fetch_data()}} for more details.}

\item{sampleid}{A \code{character(1)} specifying which sample to plot from
\code{colData(sce)$sample_name}.}

\item{clustervar}{A \code{character(1)} with the name of the \code{colData(sce)}
column that has the cluster values.}

\item{colors}{A vector of colors to use for visualizing the clusters
from \code{clustervar}. If the vector has names, then those should match the
values of \code{clustervar}.}

\item{spatial}{A \code{logical(1)} indicating whether to include the histology
layer from \code{\link[=geom_spatial]{geom_spatial()}}. If you plan to use
\link[plotly:ggplotly]{ggplotly()} then it's best to set this to \code{FALSE}.}

\item{...}{Passed to \link[base:paste]{paste0()} for making the title of the
plot following the \code{sampleid}.}
}
\value{
A \link[ggplot2:ggplot]{ggplot2} object.
}
\description{
This function visualizes the clusters for one given sample at the spot-level
using (by default) the histology information on the background. To visualize
gene-level (or any continuous variable) use \code{\link[=sce_image_gene]{sce_image_gene()}}.
}
\details{
This function subsets \code{sce} to the given sample and prepares the
data and title for \code{\link[=sce_image_clus_p]{sce_image_clus_p()}}.
}
\examples{

if (enough_ram()) {
    ## Obtain the necessary data
    if (!exists("sce")) sce <- fetch_data("sce")

    ## Check the colors defined by Lukas M Weber
    libd_layer_colors

    ## Use the manual color palette by Lukas M Weber
    sce_image_clus(
        sce = sce,
        clustervar = "layer_guess_reordered",
        sampleid = "151673",
        colors = libd_layer_colors,
        ... = " LIBD Layers"
    )

    ## Without histology
    sce_image_clus(
        sce = sce,
        clustervar = "layer_guess_reordered",
        sampleid = "151673",
        colors = libd_layer_colors,
        ... = " LIBD Layers",
        spatial = FALSE
    )
}
}
\seealso{
Other Spatial cluster visualization functions: 
\code{\link{sce_image_clus_p}()},
\code{\link{sce_image_grid}()}
}
\concept{Spatial cluster visualization functions}
