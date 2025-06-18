#import "@preview/clean-math-paper:0.2.0": *

#let date = datetime.today().display("[month repr:long] [day], [year]")
#show: template.with(
  title: "Measurement-Free Error Correction via Multi-Qubit Syndrome Gate Encoding",
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
  abstract: [Logical qubits can be protected from decoherence by performing quantum error correction. Naturally, the QEC algorithm requires feedback process to specific hardware platform which takes more time and cause extra error. In our sheme, we intend to develop a measurement-free error correction scheme based on surface code. With individually addressable, optically trapped, dual-species Rydberg atoms, we perform the multiqubit parity gates to map the message from data qubits to ancilla qubit and design a error-correction process without measurement feedback.    ],
  keywords: ("measurement-free error correction", "dual species", "parity-gate", "multi-qubit gate", "etc"),
  AMS: ("65M70", "65M12", )
)

= Motivation
1. In order to eliminate the time required for quantum error correction process, we intend to develop a parity-controlled multiqubit gate to perform one-step syndrome mapping from data qubits to ancilla qubit.

2. After the syndrome mapping, we perform measurement-free error correction with the ancella qubit. 

== Model 
The model is shown below. 
#figure(
  image("model.png", width: 51%),
)
There are two species of atoms. The data qubits are Cs atoms, and the ancilla qubits are Rb atoms. The Cs atoms are trapped in a 2D optical lattice, and the Rb atoms locates in the center of each plaquette. The interaction strength satisfies $V_"dd">>V_"vdws"$, where interactions between atoms of the same species are negligible. The $"CNOT"_k$ gate can map the syndrome information in one round without the requirement of moving atoms. Also, the dual-species Rydberg array can avoid the crosstalk between data qubits and ancilla qubits.

#figure(
  image("model2.png", width: 55%),
)
The whole process can be divided into two steps. Frome the figure shown above, we assume that an Z-error occurs in the middle data qubit "5". The syndrome information is mapped to the ancilla qubit denoted by red points through the multi-qubit gate. After that, we perform a measurement-free error correction process with the ancilla qubit acting as a control qubit in another multiqubit gate. The error qubit can be corrected by the ancella qubit with syndrome information.




= Literature Review
1. Construction of multi-qubit $"CNOT"_k$ gate through EIT:@PhysRevA.96.052320, through optimization of the pulse@kazemi2025multiqubitparitygatesrydberg, through adiabatic pulse design@PhysRevLett.128.120503; Parity gate construction through specially designed interaction strength@guo2025paritycontrolledgatetwodimensionalneutralatom

2. Measurement-free fault-tolerant quantum error correction:@Heu_en_2024

3. Mid-circuit correction of correlated phase errors using an array of spectator qubits@Singh2023










#bibliography("bibliography.bib")

// Create appendix section
//#show: appendices

