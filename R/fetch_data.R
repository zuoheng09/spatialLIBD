#' Download the Human DLPFC Visium data from LIBD
#'
#' This function downloads from `ExperimentHub` the dorsolateral prefrontal
#' cortex (DLPFC) human Visium data and results analyzed by LIBD. If
#' `ExperimentHub` is not available, it will download the files from Dropbox
#' using [utils::download.file()] unless the files are present already at
#' `destdir`. Note that `ExperimentHub` will cache the data and automatically
#' detect if you have previously downloaded it, thus making it the preferred
#' way to interact with the data.
#'
#' @param type A `character(1)` specifying which file you want to download. It
#' can either be: `sce` for the
#' \linkS4class{SingleCellExperiment}
#' object containing the spot-level data that includes the information for
#' visualizing the clusters/genes on top of the Visium histology, `sce_layer`
#' for the
#' \linkS4class{SingleCellExperiment}
#' object containing the layer-level data (pseudo-bulked from the spot-level),
#' or `modeling_results` for the list of tables with the `enrichment`,
#' `pairwise`, and `anova` model results from the layer-level data. It can also
#' be `sce_example` which is a reduced version of `sce` just for example
#' purposes.
#'
#' @param destdir The destination directory to where files will be downloaded
#' to in case the `ExperimentHub` resource is not available. If you already
#' downloaded the files, you can set this to the current path where the files
#' were previously downloaded to avoid re-downloading them.
#' @param eh An `ExperimentHub` object
#' [ExperimentHub-class][ExperimentHub::ExperimentHub-class].
#'
#' @return The requested object: `sce`, `sce_layer` or `modeling_results` that
#' you have to assign to an object. If you didn't you can still avoid
#' re-loading the object by using `.Last.value`.
#'
#' @export
#' @import ExperimentHub
#' @importFrom AnnotationHub query
#' @importFrom methods is
#' @details The data was initially prepared by scripts at
#' https://github.com/LieberInstitute/HumanPilot and further refined by
#' https://github.com/LieberInstitute/spatialLIBD/blob/master/inst/scripts/make-data_spatialLIBD.R.
#'
#' @examples
#'
#' ## Download the SingleCellExperiment object
#' ## at the layer-level
#' if (!exists("sce_layer")) sce_layer <- fetch_data("sce_layer")
#'
#' ## Explore the data
#' sce_layer
fetch_data <-
    function(type = c("sce", "sce_layer", "modeling_results", "sce_example"),
    destdir = tempdir(),
    eh = ExperimentHub::ExperimentHub()) {
        ## Some variables
        sce <- sce_layer <- modeling_results <- sce_sub <- NULL

        ## Check inputs
        stopifnot(methods::is(eh, "ExperimentHub"))
        if (!type %in% c("sce", "sce_layer", "modeling_results", "sce_example")) {
            stop(
                paste(
                    "Other 'type' values are not supported.",
                    "Please use either 'sce', 'sce_layer',",
                    "'modeling_results' or 'sce_example'."
                ),
                call. = FALSE
            )
        }

        if (type == "sce") {
            if (!enough_ram()) {
                warning(paste(
                    "Your system might not have enough memory available.",
                    "Try with a machine that has more memory",
                    "or use the 'sce_example'."
                ))
            }

            hub_title <- "Human_Pilot_DLPFC_Visium_spatialLIBD_spot_level_SCE"

            ## While EH is not set-up
            file_name <-
                "Human_DLPFC_Visium_processedData_sce_scran_spatialLIBD.Rdata"
            url <-
                "https://www.dropbox.com/s/f4wcvtdq428y73p/Human_DLPFC_Visium_processedData_sce_scran_spatialLIBD.Rdata?dl=1"
        } else if (type == "sce_layer") {
            hub_title <- "Human_Pilot_DLPFC_Visium_spatialLIBD_layer_level_SCE"

            ## While EH is not set-up
            file_name <-
                "Human_DLPFC_Visium_processedData_sce_scran_sce_layer_spatialLIBD.Rdata"
            url <-
                "https://www.dropbox.com/s/bg8xwysh2vnjwvg/Human_DLPFC_Visium_processedData_sce_scran_sce_layer_spatialLIBD.Rdata?dl=1"
        } else if (type == "modeling_results") {
            hub_title <- "Human_Pilot_DLPFC_Visium_spatialLIBD_modeling_results"

            ## While EH is not set-up
            file_name <- "Human_DLPFC_Visium_modeling_results.Rdata"
            url <-
                "https://www.dropbox.com/s/se6rrgb9yhm5gfh/Human_DLPFC_Visium_modeling_results.Rdata?dl=1"
        } else if (type == "sce_example") {
            hub_title <- "Human_DLPFC_Visium_sce_example.Rdata"

            ## While EH is not set-up
            file_name <- "sce_sub_for_vignette.Rdata"
            url <-
                "https://www.dropbox.com/s/5ra9o8ku9iyyf70/sce_sub_for_vignette.Rdata?dl=1"
        }

        file_path <- file.path(destdir, file_name)
        ## Use local data if present
        if (!file.exists(file_path)) {
            q <-
                AnnotationHub::query(eh,
                    pattern = c("Human_Pilot_DLPFC_Visium_spatialLIBD", hub_title)
                )

            if (length(q) == 1) {
                ## ExperimentHub has the data =)
                return(q[[1]])
            } else {
                ## ExperimentHub backup: download from Dropbox
                ## Create the destination directory if it doesn't exist
                dir.create(destdir,
                    showWarnings = FALSE,
                    recursive = TRUE
                )
                utils::download.file(url,
                    destfile = file_path,
                    quiet = TRUE,
                    mode = "wb"
                )
            }
        }

        ## Now load the data
        load(file_path, verbose = TRUE)
        if (type == "sce") {
            return(sce)
        } else if (type == "sce_layer") {
            return(sce_layer)
        } else if (type == "modeling_results") {
            return(modeling_results)
        } else if (type == "sce_example") {
            return(sce_sub)
        }
    }
