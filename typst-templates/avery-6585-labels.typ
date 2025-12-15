// to make a pdf of labels to be printed on Avery 6585 labels
// in a terminal "typst compile avery-6585-labels.typ -f pdf"
// make usre "christmas-card-list" is in the folder you are running it from
// Avery 6585 Label
#let label_width = 2.625in
#let label_height = 1.0in
#let top_margin = 0.5in
#let bottom_margin = 0.5in
#let left_margin = 0.1875in
#let right_margin = 0.1875in
#let h_gutter = 0.125in
#let v_gutter = 0in
#let columns_count = 3
#let rows_count = 10

#let christmas_list = csv("./christmas-card-list.csv", row-type: dictionary)

// Page settings
#set page(
  paper: "us-letter",
  margin: (
    top: top_margin,
    right: right_margin,
    bottom: bottom_margin,
    left: left_margin,
  )
)

#set text(
  size: 10pt,
)

#let filtered_christmas_list = christmas_list.filter(r => r.NoSend != "true")

#for recipients in filtered_christmas_list.chunks(columns_count * rows_count) {
  grid(
    columns: columns_count*(1fr,),
    rows: rows_count*(1fr,),
    column-gutter: h_gutter,
    row-gutter: v_gutter,
    align: center + horizon,
    ..recipients
    .map(r =>
    block(
        width: label_width,
        height: label_height,
        inset: 3pt,
      )[
        #text(r.Envelope)\
        #text(r.Address01) #text(r.Address02)\
        #if r.Address03 != "" { text(r.Address03);linebreak() }
        #text(r.City), #text(r.State) #text(r.Zip)
        #if r.Country != "" { linebreak();text(r.Country) }
      ]
    )
  )
}
