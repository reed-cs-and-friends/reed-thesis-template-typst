#let current-chapter-title(rank: 1) = context {
    let headings = query(heading.where(level: rank).before(here()))
    if headings == () { return " " }
    let candidate = headings.last()

    if rank != 1 {
      let headings = query(heading.where(level: 1).before(here()))
      if headings == () { panic("At least one heading must be defined.") }
      let chapter = headings.last()

      if counter(page).at(chapter.location()) > counter(page).at(candidate.location()) {
        candidate = heading([])
      }
    }

    candidate.body
}

#let fill(width) = box(width: width, repeat(sym.space))

#let end_introduction() = {
  set heading(numbering: "1.1")
  counter(heading).update(0)
}

#let thesis(
  title: none,
  author: none,
  advisor: none,
  department: none,
  division: none,
  acknowledgements: none,
  preface: none,
  abbreviations: none,
  abstract: none,
  dedication: none,
  do_outline: true,
  do_figures: true,
  cited: none,
  bibstyle: "ieee",
  date: datetime.today(),
  doc,
) = {

  set align(center)

  set cite(style: "alphanumeric")

  set par(first-line-indent: 1em)

  set page("us-letter", margin: (outside: 1in, inside: 1.5in, top: 2in, bottom: 1in), numbering: none, footer: none)
  [
    #set align(center)
    #set text(size: 11pt)
    #set par(leading: 11pt)
    #set line(length: 2.5in, stroke: 0.4pt)
    #title
    #v(64pt - 11pt)
    #line()
    #v(56pt - 11pt)
    A Thesis \
    Presented to\
    The Division of #division\
    Reed College
    #v(64pt - 11pt)
    #line()
    #v(56pt - 11pt)
    In Partial Fulfillment \
    of the Requirements for the Degree \
    Bachelor of Arts
     #v(64pt - 11pt)
    #line()
    #v(56pt - 11pt)
    #author \
    \
    #date.display("[month repr:long] [year]")
    #pagebreak()
    #pagebreak()
    #set align(horizon)
    Approved for the Division \
    (#department)
    #v(64pt - 11pt)
    #line(length: 1.7in)
    #advisor
  ]

  set page(header: context {
    let curr_page = here().page()
    let header1s = query(selector(heading.where(level: 1)))
    let anchor = header1s.map(it => {it.location().page()})

    let current = counter(page).get()
    let page = current.first()

    if not curr_page in anchor and page > 1 {
      if calc.rem(current.first(), 2) == 0 [
      #current-chapter-title()
      #h(1fr)
      #page
      #v(-0.7em)
      #line(length: 100%, stroke: 0.5pt)
    ] else [
       #page
      #h(1fr)
      #current-chapter-title(rank: 2)
      #v(-0.7em)
      #line(length: 100%, stroke: 0.5pt)
    ]
    }
   })
  set align(left)

  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading and el.level == 1 {
      show underline: it => it.body
      link(el.location(),
      numbering(
          (num) => el.supplement + " " + str(num),
          ..counter(heading).at(el.location())
      ))
    } else {
      it
    }
  }
  show ref: it => {
    emph(it)
  }

  show outline.entry: it => link(
    it.element.location(),
    it.indented({
      let pf = it.prefix()
      let r = repr(pf)
      if r.contains("Chapter ") or r.contains("Appendix") { pf + ":" } else { it.prefix() }
    }, it.inner()),
  )

  show outline.entry.where(level: 1): it => strong[#it]

  show heading.where(level: 1, outlined: true, numbering: "1.1"): set heading(
    numbering: (.., last) => {
        "Chapter " + str(last)
    },
    supplement: [Chapter]
  )

  show heading.where(level: 1, outlined: true, numbering: "A"): set heading(
    numbering: (.., last) => {
      "Appendix " + numbering("A", last)
    },
    supplement: [Appendix]
  )

  show heading.where(level: 1, outlined: true, supplement: [Chapter])
    .or(heading.where(level: 1, outlined: true, supplement: [Appendix])): it => {
  block(
      if it.numbering == none {
        it
      } else {
      [
        #counter(heading).display(it.numbering)
        #v(-1em) \
        #it.body
      ]
    }
  )}

  show heading.where(level: 1): it => {
    {
      set page(header: none)
      pagebreak(to: "odd")
    }
    it
  }

  show heading.where(level: 1): set block(below: 2em)
  show heading.where(level: 1): set text(size: 22pt, weight: "semibold")
  show heading.where(level: 1): set heading(supplement: "Chapter")

  show heading.where(level: 2): set block(below: 1.2em)
  show heading.where(level: 2): set text(size: 15pt, weight: "medium")

  [
    #set heading(outlined: false, numbering: none)

    #if acknowledgements != none [
      #acknowledgements
    ]

    #if do_outline [
      #outline(title: [Table of Contents])
    ]

    #if preface != none [
      = Preface
      #preface
    ]

    #if abbreviations != none [
      = List of Abbreviations
      #abbreviations
    ]

    #if do_figures [
      #outline(
        title: [List of Figures],
        target: figure,
      )
    ]

    #if abstract != none [
       = Abstract
      #abstract
    ]

    #if dedication != none [
      #dedication
    ]
  ]

  set heading(outlined: true, numbering: (..x) => numbering(
    "1.1",
    ..x.pos()
      .enumerate()
      .map(((i, n)) => if i == 0 { calc.max(n - 1, 0) } else { n })
  ))
  set page(numbering: "1")
  counter(page).update(0)

  doc

  if cited != none {
    heading("References", numbering: none)
    bibliography(bytes(cited), full: true, title: none, style: bibstyle)
  }
}
