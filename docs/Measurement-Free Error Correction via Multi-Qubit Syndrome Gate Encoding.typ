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
  abstract: [Logical qubits can be protected from decoherence by performing quantum error correction. Naturally, the QEC algorithm requires feedback process to specific hardware platform which takes more time and cause extra error. In our sheme, we intend to develop a measurement-free error correction scheme based on surface code. With individually addressable, optically trapped, dual-species Rydberg atoms, we perform the multiqubit parity gates to map the message from data qubits to ancilla qubit and design a error-correction process without measurement feedback.],
  keywords: ("measurement-free error correction", "dual species", "parity-gate", "multi-qubit gate", "etc"),
  AMS: ("65M70", "65M12", )
)

= Motivation
1. In order to eliminate the time required for quantum error correction process, we intend to develop a parity-controlled multiqubit gate to perform one-step syndrome mapping from data qubits to ancilla qubit. In this work, we intend to design a $"CNOT"_4$ gate based on the electromagnetically induced transparency(EIT) technique and Rydberg blockade effect. 
2. After the syndrome mapping, there is a change in the ancilla qubit state. We will apply another pulse sequence to manipulate a $C_2$NOT gate to fix the error qubit. Thus, we do not need to perform measurement on the ancilla qubit, and the error correction process can be completed in one step.

== Model(Overview)

We intend to perform the measurement-free error correction process on surface code with dual-species Rydberg atoms. The model is shown below. There are two species of atoms. The data qubits are Cs atoms, and the ancilla qubits are Rb atoms. The Cs atoms are trapped in a 2D optical lattice, and the Rb atoms locates in the center of each plaquette.

The interaction strength satisfies $V_"dd">>V_"vdws"$, where interactions between atoms of the same species are negligible, which largely reduces the error caused by undesirable interactions between data qubits. The $"CNOT"_k$ gate can map the syndrome information in one round without the requirement of moving atoms. 
#figure(
  image("model.png", width: 51%),
)
After the syndrome mapping process, we will apply another time sequence to perform a $C_2$NOT gate to correct the error qubit. The ancilla qubit acts as a control qubit(red dots), and the errored data qubit is the target qubit(black dot 5). The model is shown below:
#figure(
  image("model2.png", width: 55%),
)
//The whole process can be divided into two steps. Frome the figure shown above, we assume that an Z-error occurs in the middle data qubit "5". The syndrome information is mapped to the ancilla qubit denoted by red points through the multi-qubit gate. After that, we perform a measurement-free error correction process with the ancilla qubit acting as a control qubit in another multiqubit gate. The error qubit can be corrected by the ancella qubit with syndrome information.

- Why dual-species Rydberg atoms?

  Based on the multi-qubit $"CNOT"_k$ gate implementation@photonics10111280, the fidelity is limited by the undesirable interaction between data qubits. Thus, choosing dual-species Rydberg atoms can overcoming these limits by using strong heteronuclear dipole–dipole interactions via Förster resonances for control and target atoms, while the target atoms are coupled by a weaker van der Waals interaction.

  Also, the dual-species Rydberg array can avoid the crosstalk between data qubits and ancilla qubits.

== multi-qubit $"CNOT"_4$ gate

In the syndrome mapping process, we need to perform a $C_4$NOT parity gate which can be converted to a $"CNOT"_4$ gate through some single-qubit operation. 
#figure(
  image("circuit.png", width: 55%),
)
The scheme of multiqubit $"CNOT"_4$ gate proposed in ref.@PhysRevLett.128.120503. The energy level and coupling diagram are:
#figure(
  image("energy_level.png", width: 64%),
)
The classical pulse sequence based on the EIT technique is shown below:
#figure(
  image("sequence.png", width: 42%),
)
The gate operation can be understood as follows: 

(i) If the control atom is initially in the ground state $|0 angle.r$, the first $pi$-pulse does not change its quantum state. The Raman transfer between states $|A angle.r$ and $|B angle.r$ is inhibited due to the interaction with intensive resonant coupling radiation with Rabi-frequency $Omega_c$. 

(ii) If the control atom is initially in state $|1 angle.r$, it will be coupled to Rydberg state with $Omega_r$. The Rydberg energy level of target atoms will be shifted by the interaction with control atom, and the coupling pulse will be off-resonant. The Raman population transfer between state $|A angle.r$ and $|B angle.r$ is allowed.

#figure(
  image("transfer.png", width: 60%),
)

== Multi-qubit $C_2"NOT"$ gate construction
In this section, we intend to design a multi-qubit $C_2"NOT"$ gate to correct the error qubit. The two ancilla qubits acts as a control qubit, and the errored data qubit is the target qubit. The model is shown below:
#figure(
  image("2qubitgate.png", width: 95%),
)
In this $C_2"NOT"$ gate model, we assume a unbalanced interaction strength similar to the proposed $"CNOT"_4$ gate. The ancilla qubits(green dots) are control qubits and the errored data qubit(blue dot) is the target qubit. The interaction strength satisfies $V_"dd">>V_"vdws"$, where interactions between atoms of the same species are negligible. The pulse sequence is also shown from (i) to (v). All the pulses can be implemented with square pulse. The gate operation can be understood as follows:

(i) The control qubits are initially in the ground state $|0 angle_c$. The first $pi$-pulse (i) can couple it to the Rydberg state $|c angle.r_c$ and the target qubit is unchanged due to the strong dipole-dipole interactions. 

(ii) The control qubits are initially in state $|1 angle.r_c$. The first $pi$-pulse (i) cannot couple the control qubits. Thus, the target qubit can be switched between state $|0 angle_t$ and $|1 angle_t$ through pulse sequence (ii) to (iv). 

= Literature Review
1. Construction of multi-qubit $"CNOT"_k$ gate through EIT:@PhysRevA.96.052320, through optimization of the pulse@kazemi2025multiqubitparitygatesrydberg, through adiabatic pulse design@PhysRevLett.128.120503@photonics10111280 and experimental realization:@PhysRevA.102.042607@PhysRevLett.129.200501; Parity gate construction through specially designed interaction strength@guo2025paritycontrolledgatetwodimensionalneutralatom.

2. Measurement-free fault-tolerant quantum error correction:@Heu_en_2024

3. Mid-circuit correction of correlated phase errors using an array of spectator qubits@Singh2023








#bibliography("bibliography.bib")

// Create appendix section
//#show: appendices

