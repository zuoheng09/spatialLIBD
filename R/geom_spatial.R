#' Title
#'
#' @param mapping
#' @param data
#' @param stat
#' @param position
#' @param na.rm
#' @param show.legend
#' @param inherit.aes
#' @param ...
#'
#' @return
#' @author 10x Genomics
#' @export
#'
#' @examples

geom_spatial <-  function(mapping = NULL,
    data = NULL,
    stat = "identity",
    position = "identity",
    na.rm = FALSE,
    show.legend = NA,
    inherit.aes = FALSE,
    ...) {
    GeomCustom <- ggproto(
        "GeomCustom",
        Geom,
        setup_data = function(self, data, params) {
            data <- ggproto_parent(Geom, self)$setup_data(data, params)
            data
        },

        draw_group = function(data, panel_scales, coord) {
            vp <- grid::viewport(x = data$x, y = data$y)
            g <- grid::editGrob(data$grob[[1]], vp = vp)
            ggplot2:::ggname("geom_spatial", g)
        },

        required_aes = c("grob", "x", "y")

    )

    layer(
        geom = GeomCustom,
        mapping = mapping,
        data = data,
        stat = stat,
        position = position,
        show.legend = show.legend,
        inherit.aes = inherit.aes,
        params = list(na.rm = na.rm, ...)
    )
}