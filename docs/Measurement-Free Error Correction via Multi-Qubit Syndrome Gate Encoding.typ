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

= Model(Overview)

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
  image("energy_level.png", width: 60%),
  caption:[In the model, the control atom is Cs atom and the target atoms are Rb atoms. The energy levels of Cs atom are $|0 angle.r_c = |6S_(1\/2), F=4 angle.r$, $|1 angle.r_c = |6S_(1\/2), F=3 angle.r$, $|r angle.r_c = |81S_(1\/2), m_j = -1\/2 angle.r$. The energy level of target atoms are $|R angle.r_t = |77S_(1\/2), m_j = 1\/2 angle.r$, $|P angle.r_t = |6P_(3\/2)angle.r$, $|A angle.r_t = |5S_(1\/2), F=1 angle.r$, and $|B angle.r_t = |5S_(1\/2), F=2 angle.r$. The coupling process is shown in figure. In the coupling process, $Omega_p = Omega_"max" sin^2(pi/T_p (t-T_c))$, $Omega_"max"=Omega_r = 2pi times 50 "MHz"$; $Omega_c = 2.5Omega_"max" = 2pi times 125"MHz"$; and the detuning $Delta = 2pi times 1200 "MHz"$ The interaction strength between atoms is denoted by $V_"dd"$ and $V_"vdws"$. We assume that the distance betwwn control and target atoms is $d = 5 "um"$.],
)<glacier>
The classical pulse sequence based on the EIT technique is shown below@photonics10111280:
#figure(
  image("sequence.png", width: 40%),
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

== Pulse sequence

The pulse sequence is shown below:
#figure(
  image("pulsesequence.png", width: 95%),
  caption:[The whole sequence of measurement-free error correction process. If one of the data qubits is errored, we can perform two rounds of syndrome mapping and error correction process to achieve the measurement-free correction no matter the occured error is bit-flip(X-error) or phase-flip(Z-error). In the first round, the effective $C_4"NOT"$ gate(for control qubits and one target qubit) is performed by a $"CNOT"_4$ gate and two Hadamard gates(the area surrounded by gray dashed square). Then, we perform a $C_2"NOT"$ gate(two control qubits and one target qubit shown as red dashed rigion) to flip the errored qubit if the error type is X-error. Finally, we perform a $pi$-pulse to reset the ancilla qubit to the ground state. In the second round, the implementation of effective $C_4 Z$ gate is shown in the second gray dashed square, which is to map the syndrome information to the ancilla qubit. Then we perform a effective $C_2"Z"$ gate (the methond is shown in red-dashed square) to correct the errored qubit if the error type is Z-error. The ancilla qubit is also required reset after the error correction process.],
)


== Dual species architecture

The interaction hamiltonian between control qubit and target qubits is given by: 

$ h_"ct" = C_3(1-3cos^2 theta_"CT")|r angle.r angle.l r| times.circle |R angle.r angle.l R| $

where $C_3 =2pi times 10 "GHz" dot mu m^3$, for target atoms in Rydberg state $|R angle.r$, $C_6 = 2pi times 2036"GHZ" dot mu m^6$

= Literature Review
1. Construction of multi-qubit $"CNOT"_k$ gate through EIT:@PhysRevA.96.052320, through optimization of the pulse@kazemi2025multiqubitparitygatesrydberg, through adiabatic pulse design@PhysRevLett.128.120503@photonics10111280 and experimental realization:@PhysRevA.102.042607@PhysRevLett.129.200501; Parity gate construction through specially designed interaction strength@guo2025paritycontrolledgatetwodimensionalneutralatom.

2. Measurement-free fault-tolerant quantum error correction:@Heu_en_2024

3. Mid-circuit correction of correlated phase errors using an array of spectator qubits@Singh2023








#bibliography("bibliography.bib")

// Create appendix section
//#show: appendices

