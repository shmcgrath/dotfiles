// note.typ

#let note(meta, body) = {
  set text(font: "Libertinus Serif")

  set document(title: meta.title)

  align(center)[
    text(size: 18pt, weight: "bold")[meta.title]
  ]

  v(0.5em)

  text(size: 9pt, fill: gray)[
    "uid: " + meta.uid + "\n"
    "date: " + meta.date + "\n"
    "tags: " + meta.tags.join(", ")
  ]

  v(1em)

  body
}
