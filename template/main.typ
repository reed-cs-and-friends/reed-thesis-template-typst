#import "@local/reed-thesis-template:1.0.1": *
#import "@preview/muchpdf:0.1.0": muchpdf

#show: thesis.with(
  title: [
    My Thesis Title
  ],
  author: "Your Name",
  advisor: "Your Advisor",
  department: "Computer Science",
  division: "Mathematical and Natural Sciences",
  cited: read("cited.bib"),
  // The month and year that you submit your final draft to the library (May or December)
  date: datetime(year: 2026, month: 5, day: 1),
  do_figures: true,
  do_outline: true,
  // Acknowledgements, preface, and abbreviations are optional
  acknowledgements: [I want to thank a few people.],
  preface: [This is an example of a document using the Reed thesis template.],
  abbreviations: [
    You can always change the way your abbreviations are formatted. You can also completely remove this chapter if you have no need for a list of abbreviations. Here is an example of what this could look like:

    #table(
      columns: (auto, 1fr),
      [ABC], [American Broadcasting Company],
      [CBS], [Columbia Broadcasting System],
      [CDC], [Center for Disease Control],
      [CIA], [Central Intelligence Agency],
      [CLBR], [Center for Life Beyond Reed],
      [CUS], [Computer User Services],
      [FBI], [Federal Bureau of Investigation],
      [NBC], [National Broadcasting Corporation],
    )
  ],
  // Should be less than a page in length; not required for creative theses
  abstract: [The preface pretty much says it all.],
  dedication: [
    #{
      show heading: none
      heading(numbering: none)[Dedication]
    }
    =

    #align(center)[_You can have a dedication here if you wish_]
  ],
)

#show link: underline

#heading(numbering: none)[Introduction]
Welcome to the Typst~thesis template. If you've never used Typst~before, you'll have an initial learning period to go through, but the results of a nicely formatted thesis are worth it for more than the aesthetic benefit: markup like Typst~is more consistent than the output of a word processor, much less prone to corruption or crashing, and the resulting file is smaller than a Word file. While you may have never had problems using Word in the past, your thesis is going to be about twice as large and complex as anything you've written before, taxing Word's capabilities. If you're still on the fence about using Typst, read the #link("https://typst.app/docs/tutorial/")[Typst tutorial] and skim the following template and give it a few weeks. Pretty soon all the markup gibberish will become second nature.

== Why use it?
The LaTeX template that this Typst template was based on explained that:
#quote(block: true)[
  LaTeX does a great job of formatting tables and paragraphs. Its line-breaking algorithm was the subject of a PhD. thesis. It does a fine job of automatically inserting ligatures, and to top it all off it is the only way to typeset good-looking mathematics.
]

Typst has all the benefits of LaTeX, but with considerably less clunky syntax, real-time preview, and better error messages. If you use Typst for your thesis, you will spend less time worrying about syntax, formatting, and `overfull \hbox`es, and more time writing your document (or doing whatever else you want to be doing during your senior year). If you are a math major, do not fret; Typst can typeset mathematics just as well as LaTeX can!


== Who should use it?
Anyone who needs to use math, tables, a lot of figures, complex cross-references, IPA or who just cares about the final appearance of their document should use Typst. At Reed, math majors are required to use a typesetting system like Typst or LaTeX, most physics majors will want to use it, and many other science majors may want it also.

#end_introduction()

#set math.equation(numbering: "1.")
#set heading(numbering: "1.1")

= The First

This is the first page of the first chapter. You may delete the contents of this chapter so you can add your own text; it's just here to show you some examples.

=== Footnotes and Endnotes
You might want to footnote something.#footnote[footnote text]

== Bibliographies
Of course you will need to cite@texbook things, and you will probably accumulate an armful of sources. This is why BibTeX was created. For more information about BibTeX and bibliographies, see our CUS site (#link("web.reed.edu/cis/help/latex/index.html"););. There are three pages on this topic: #emph[bibtex] (which talks about using BibTeX, at #link("/latex/bibtex.html");), #emph[bibtexstyles] (about how to find and use the bibliography style that best suits your needs, at #link("/latex/bibtexstyles.html");) and #emph[bibman] (which covers how to make and maintain a bibliography by hand, without BibTeX, at at #link("/latex/bibman.html");). The last page will not be useful unless you have only a few sources.

=== Tips for Bibliographies
+ Like with thesis formatting, the sooner you start compiling your bibliography for something as large as thesis, the better. Typing in source after source is mind-numbing enough; do you really want to do it for hours on end in late April? Think of it as procrastination.

+ The cite key (a citation's label) needs to be unique from the other entries.

+ When you have more than one author or editor, you need to separate each author's name by the word "and" e.g. `Author = {Noble, Sam and Youngberg, Jessica},`.

+ To force capitalization in an article title or where all lowercase is generally used, bracket the capital letter in curly braces.

+ You can add a Reed Thesis citation option. The best way to do this is to use the phdthesis type of citation, and use the optional "type" field to enter "Reed thesis" or "Undergraduate thesis".

== Anything else?
If you'd like to see examples of other things in this template, please #link("https://github.com/reed-cs-and-friends/reed-thesis-template-typst/issues/new")[file a GitHub issue] with your suggestions. We love to see people using Typst~for their theses, and are happy to help.

= Mathematics and Science

== Chemistry 101: Symbols
Exponent or Superscript: O$""^(-)$ \
Subscript: CH$""_4$ \
To stack numbers or letters as in $upright(F e_2^(2 +))$, the subscript
is defined first, and then the superscript is defined. \
Angstrom: Å \
Bullet: CuCl $bullet$ 7H$""_2$O \
Double Dagger: \
Delta: $Delta$ \
Reaction Arrows: $arrow.r$ or $arrow.r^(s o l u t i o n)$ \
Resonance Arrows: $arrow.l.r$ \
Reversible Reaction Arrows: $harpoons.rtlb$

=== Typesetting reactions
You may wish to put your reaction in a figure.

#figure(
  [
    $ upright(C_6 H_12 O_6 + 6 O_2) arrow.r upright(6 C O_2 + 6 H_2 O) $
  ],
  caption: [
    Combustion of glucose
  ],
)
#label("combustion of glucose")

=== Other examples of reactions
$upright(N H_4 C l_(\( s \))) harpoons.rtlb upright(N H_(3 \( g \)) + H C l_(\( g \)))$
\
$upright(M e C H_2 B r + M g) arrow.r_(b e l o w)^(a b o v e) upright(M e C H_2 bullet M g bullet B r)$

= Tables and Graphics

== Tables
Here's an example of a table.

#block[
  #block[
    #figure(
      align(center)[#table(
        columns: 4,
        align: (center, center, center, center),
        table.header(
          [Factors],
          [Correlation between Parents &
            Child],
          [Inherited],
        ),
        table.hline(),
        [Education], [-0.49], [Yes],
        [Socio-Economic Status], [0.28], [Slight],
        [Income], [0.08], [No],
        [Family Size], [0.19], [Slight],
        [Occupational Prestige], [0.21], [Slight],
      )],
      caption: [Correlation of Inheritance Factors between Parents and
        Child],
      kind: table,
    )<inheritance>
  ]
]

== Figures
This is how you add a figure with a `.pdf` graphic:

#figure(
  [#block[
    #box(muchpdf(read("subdivision.pdf", encoding: none)))
  ]],
  caption: [
    Subdivision of arc segments. You can see that $p_3 = p_6'$.
  ],
)

#heading(level: 1, numbering: none)[Conclusion]
#context counter(heading).update(counter(heading).get().at(0) + 1)

Here's a conclusion.

#set heading(numbering: "A", supplement: [Appendix])
#show heading.where(level: 2).or(heading.where(level: 3)): set heading(numbering: "A.1")
#counter(heading).update(0)

= The first appendix
Text goes here

= The second appendix
More text goes here
