#import "@preview/clean-math-paper:0.2.0": *

#let date = datetime.today().display("[month repr:long] [day], [year]")
#show: template.with(
  title: "Real experimental conditions of Rydberg gate",
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
  abstract: [In this note, I intend to investigate the experimental conditions of Rydberg gate based on different gate schemes],
  keywords: ("dual species", "multi-qubit gate", "etc"),
  AMS: ("65M70", "65M12", )
)

= Species of Rydberg atoms
1. In this work, we intend to design a multi-qubit CNOT gate for one-step syndrome mapping from data qubits to ancilla qubits in surface code. 
== Model










#bibliography("bibliography.bib")

// Create appendix section
//#show: appendices

