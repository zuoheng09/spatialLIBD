% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_image_path.R
\name{check_image_path}
\alias{check_image_path}
\title{Check input image_path}
\usage{
check_image_path(image_path, sce)
}
\arguments{
\item{image_path}{A path to the directory containing the low resolution
histology images that is needed for the interactive visualizations with
\code{plotly}. See
https://github.com/LieberInstitute/spatialLIBD/tree/master/inst/app/www/data
for an example of how these files should be organized.}

\item{sce}{Defaults to the output of
\code{fetch_data(type = 'sce')}. This is a
\linkS4class{SingleCellExperiment}
object with the spot-level Visium data and information required for
visualizing the histology. See \code{\link[=fetch_data]{fetch_data()}} for more details.}
}
\value{
The input object if all checks are passed.
}
\description{
This function checks that the \code{image_path} vector has the appropriate
structure. For more details please check the vignette documentation.
}
\examples{

if (enough_ram()) {
    ## Obtain the necessary data
    if (!exists("sce")) sce <- fetch_data("sce")

    ## Get the path to the images
    img_path <- system.file("app", "www", "data", package = "spatialLIBD")

    ## Check the object
    check_image_path(img_path, sce)
}
}
\seealso{
Other Check input functions: 
\code{\link{check_modeling_results}()},
\code{\link{check_sce_layer}()},
\code{\link{check_sce}()}
}
\concept{Check input functions}
