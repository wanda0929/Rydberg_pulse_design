#import "@preview/clean-math-paper:0.2.0": *
#import "@preview/cetz:0.3.2": canvas, draw, tree, vector, decorations

#let date = datetime.today().display("[month repr:long] [day], [year]")
#show: template.with(
  title: "Shortcut to adiabatic population transfer in quantum three-level systems: Effective two-level problems and feasible counterdiabatic driving",
  authors: (
    (name: "Han Wang", affiliation-id: 1, orcid: "0000-0000-0000-0000"),
    //(name: "Author 2",  affiliation-id: "2,*"),
  ),
  affiliations: (
    (id: 1, name: "HKUST(GZ)", address: "Guangzhou, China"),
   // (id: 2, name: "Affiliation 2, Address 2"),
   // (id: "*", name: "Corresponding author")
  ),
  date: date,
  heading-color: rgb("#0000ff"),
  link-color: rgb("#008002"),
  abstract: [In this note, I intend to change the pulse shape of $Omega_p$ in Y-type energy level systems and see that if the laser pulse can be optimized],
  keywords: ("measurement-free error correction", "multi-species array", "parity-gate", "multi-qubit gate", "etc"),
  AMS: ("65M70", "65M12", )
)

== Simultion
Initial pulse sequence:

- Simulation parameters:

- Simulation results:
