
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
    title: [Quantum Cellular Automata Simulation in Multi-species Rydberg Atom Array],
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
#tblock(title: [Example: Game of Life (Universal for TM)])[
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
== Quantum Cellular Automata

#tblock(title: [QCA])[
  QCA is a quantum version of CA, which can perform quantum computation.
  - cells = qubits
  - states = quantum states
  - local function G = unitary operator
  - no external control (Low noise)
]
= QCA simulation in our system

== QCA simulation in our system

#figure(
  image("model1.png", width: 110%), 
  caption: [
    QCA simulation in our system
  ],
)

== QCA simulation in our system
Effect of different pulses
- Pulse $h_D$/$h_1$/$h_2$: act on D/A1/A2, Hadamard gate
- Pulse $b_1$/$b_2$: act on A1/A2, state transition $|1 angle.r arrow.l.r |r angle.r$
- Pulse $c_D$: act on D, if any neighboring A1 or A2 qubit in state $|r angle.r$, state transition $|0 angle.r arrow.l.r |1 angle.r$, otherwise, do nothing. Note: it is a composite pulse, also known as the EIT pulse.
- Pulse $d_1$/$d_2$: act on A1/A2, state transition $|0 angle.r arrow.l.r |r angle.r$
- Pulse $e_D$: act on D, if any neighboring A1 or A2 qubit in state $|r angle.r$, do nothing, otherwise, state transition $|0 angle.r arrow.l.r |1 angle.r$

== Lattice construction
purple points means data qubits and blue "x" means ancilla qubits.
#figure(
  image("lattice.jpeg", width: 50%),
)

== Local rules
- Performing Hadamard rotation on all qubits(step1)
- Defining and performing $pi$ pulse on ancilla qubits for X-error correction(11,13,14,16,19,21,22,24)(step2)
- Defining and performing conditional EIT pulse on data qubits(step3).
- Performing step 2.(step4)
- Defining C2NOT pulse operation on data qubit and ancilla qubits(11,13,14,16,19,21,22,24) and apply it.(step5)
- Performing Hadamard rotation on all qubits(step6)
- Extracting the final state of the lattice(step7)

== Simulation results
- No error $=>$ The whole system keeps invariant

- Initially, all qubits in system are in state $|0 angle.r$, there is a single X-error on data qubit 5. After the QCA process, the neighboring ancilla qubits 16, 19 flip to state $|1 angle.r$.

- Initially, all data qubits in system are in state $|1 angle.r$, there is a single X-error on data qubit 5. After the QCA process, the neighboring ancilla qubits 13, 16, 19, 22 flip to state $|1 angle.r$.

#figure(
  image("lattice.jpeg", width: 28%),
)

== bottleneck
- Periodic boundary condition

- How to represent the state of the whole lattice with discrete steps of QCA evolution?

== 111
#bibliography("reference.bib")