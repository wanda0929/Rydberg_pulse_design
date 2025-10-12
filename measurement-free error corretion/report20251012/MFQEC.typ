
#import "@preview/touying:0.6.1": *
#import "lib.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#set text(black, font: "New Computer Modern")
#let colors = (maroon, olive, eastern)
// 定义字体颜色
#let primary-color = rgb("#1f77b4")  // 蓝色
#let error-color = rgb("#d62728")  // 红色
// 定义颜色辅助函数
#let blue-text(content) = text(fill: primary-color, content)
#let red-text(content) = text(fill: error-color, content)

// Specify `lang` and `font` for the theme if needed.
#show: hkustgz-theme.with(
  // lang: "zh",
  // font: (
  //   (
  //     name: "Linux Libertine",
  //     covers: "latin-in-cjk",
  //   ),
  //   "Source Han Sans SC",
  //   "Source Han Sans",
  // ),
  config-info(
    title: [Measurement-Free Error Correction in Rydberg atom array],
    subtitle: none, 
    author: [Han Wang],
    date: datetime.today(),
    institution: [HKUST(GZ)],
  ),
)

#title-slide()

#outline-slide()

// Extract methods
#show strong: alert
= Background
== Theoretical model
- Multi-species array
#figure(
  image("model.png", width: 80%),
)

== Global pulse sequence and level scheme
#figure(
  image("rules.png", width: 80%),
)

== Pulse shape
#figure(
  image("laser.png", width: 80%),
)

== Pulse-level simulaiton
- No flipped error
#figure(
  image("noerror.png", width: 35%),
)

- Single X-error
#figure(
  image("error.png", width: 35%),
)

= Quantum cellular automata
== cellular automata
#tblock(title: [What is CA (cellular automata)])[
  CA consists of an array of identical cells, each of which can be in one of a finite number of states. The cells update their states synchronously according to a local function G in discrete time steps. 
]

#tblock(title: [What can CA (cellular automata) do?])[
  It can evolve automatically according to the local rules without any external control. 
]

#figure(
  image("CA1.png", width: 60%), 
  caption: [
    Cellular Automata
  ],
)

#figure(
  image("CA2.png", width: 60%), 
  caption: [
    Cellular Automata
  ],
)

#tblock(title: [CA (cellular automata) for universal computation ])[
  Universal CA is universal for classical computation @10.5555-2, which, likes Turing machine, exhibits universality. 
]
#tblock(title: [Example: Game of Life （Universal for TM）])[
  CA have been widely used in the study of complex systems, such as the Game of Life by Conway.
  
  In 2D grid, each cell has 8 neighbors.

  If the cell is alive, then it stays alive if it has either 2 or 3 live neighbors
  
  If the cell is dead, then it springs to life only in the case that it has 3 live neighbors
]

#figure(
  image("Gameoflife.png", width: 45%), 
  caption: [
    Game of Life by Conway
  ],
)






#bibliography("reference.bib")