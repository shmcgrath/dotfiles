#let make-table(headers, rows, columns: none, stroke: 0.5pt + gray) = {
  table(
    columns: if columns == none {
      (..headers.map(_ => 1fr))
    } else {
      columns
    },
    inset: 6pt,
    stroke: stroke,

    ..headers.map(h => [*#h*]),
    ..rows.map(row => row.map(cell => [#cell])).flatten()
  )
}
