#import "@preview/clean-math-paper:0.2.0": *

#let date = datetime.today().display("[month repr:long] [day], [year]")
#show: template.with(
  title: "Details of mesoscopic Rydberg gate based on EIT",
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
  abstract: [The mapping process from data qubits to ancilla qubits in surface code is of great importance for quantum error correction(QEC). In this note, we intend to design a multi-qubit gate to perform one-step syndrome mapping from data qubits to ancilla qubit, which can eliminate the time required for quantum error correction process.],
  keywords: ("EIT", "dual species", "multi-qubit gate", "etc"),
  AMS: ("65M70", "65M12", )
)

= Motivation
1. In this work, we intend to design a multi-qubit CNOT gate for one-step syndrome mapping from data qubits to ancilla qubits in surface code. 
== Model 
In surface code, we assume that there is an X-flip error happens in the data qubits, and the error information can be mapped to ancilla qubits through a multi-qubit $"CNOT"_k$ gate with four control qubits and one target qubit in one plaquette. 
#figure(
  image("model.png", width: 51%),
)
Within one plaquette, the four data qubits(Cs) are target qubits(Rb) and the ancilla qubit is the control qubit. The interaction strength satisfies the condition: $V_("dd")>>V_("Vdws")$ so that the target qubits can only be blocked by the control qubit. The energy level of control qubits and target qubit are shown below:

#figure(
  image("energy_level.png", width: 75%),
)

The mapping process can be described as follows. The multi-qubit gate shown above can be converted to a $C_k"NOT"$ gate with four control qubits and one target qubit through simple transformation.

#figure(
  image("circuit.png", width: 55%),
)





= Literature Review
1. mesoscopic Rydberg gate based on EIT:@PhysRevLett.128.120503
2. Experimental realization:@PhysRevA.102.042607@PhysRevLett.129.200501

3. There is a scheme familiar to this work@photonics10111280










#bibliography("bibliography.bib")

// Create appendix section
//#show: appendices

