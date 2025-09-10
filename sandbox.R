library(g6R)
library(igraph)
library(jsonlite)

# TODO: Define edges in external sheet/table

nodes <- fromJSON("data/nodes.json")
edges <- read.csv("data/edges.csv")

g6(nodes, edges) |>
  g6_options(
    node = list(
      style = list(
        labelBackground = TRUE,
        labelBackgroundFill = '#FFB6C1',
        labelBackgroundRadius = 4,
        labelFontFamily = 'Arial',
        labelPadding = c(0, 4),
        labelText = JS(
          "(d) => {
            return d.labels
        }"
        )
      )
    ),
    edge = list(
      style = list(endArrow = TRUE)
    )
  ) |>
  g6_layout(d3_force_layout()) |>
  g6_behaviors(
    drag_element_force(fixed = TRUE),
    click_select(
      multiple = TRUE,
      onClick = JS(
        "(e) => {
            console.log(e);
          }"
      )
    ),
    brush_select(),
    create_edge(),
    zoom_canvas(),
    collapse_expand(),
    drag_canvas(),
    drag_element()
  ) |>
  g6_plugins(
    "minimap",
    "tooltip",
    context_menu()
  )
