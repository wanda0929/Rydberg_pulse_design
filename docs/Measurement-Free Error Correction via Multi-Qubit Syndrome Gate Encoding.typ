#import "@preview/clean-math-paper:0.2.0": *
#import "@preview/cetz:0.3.2": canvas, draw, tree, vector, decorations

#let date = datetime.today().display("[month repr:long] [day], [year]")
#show: template.with(
  title: "Measurement-Free Error Correction scheme in Rydberg atoms",
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
1. In order to eliminate the time required for quantum error correction process, we intend to develop a parity-controlled multiqubit gate to perform one-step syndrome mapping from data qubits to ancilla qubit. 

2. After the syndrome mapping, there is a change in the ancilla qubit state if there is an error in data qubits. We will apply another pulse sequence to manipulate a $C_2$NOT gate to fix the error qubit. Thus, we do not need to perform measurement on the ancilla qubit, and the error correction process can be completed in one step.

= Model(Overview)

The figure shown below is the measurement-free error correction model in toric code space. There are totally three species of atoms with green and red dots represent ancilla qubits and the blue dots represents the data qubits. 
#figure(
  image("threespecies.png", width: 40%),
)
In the model shown above, we intend to perform an effective $C_4"NOT"$ parity gate. If an Z error occurs in the data qubit, the neighboring red dots will flip. If an X error occurs in the data qubit the neighboring green dots will flip. Then, we intend to perform a $C_2"NOT"$ gate where the ancilla qubits acts as control qubits, and the errored data qubit is the target qubit. The $C_2"NOT"$ gate will correct the errored qubit without measuring process. 

== Interactions between atoms
In this multi-qubit platform, we intend a strong dipole-dipole interaction between different atom species and weak van der Waals interaction between atoms of the same species. ($V_"dd">>V_"vdws"$), where interactions between atoms of the same species are negligible. It largely reduces the error caused by undesirable interactions between data qubits and crosstalk between data qubits and ancilla qubits.

== Effective parity check and error-correction
The effective syndrome mapping $C_4"NOT"$ gate can be implemented through H-gate and $"CNOT"_4$ gate with the ancilla qubit in the center of the plaquette acts as the control qubit and the data qubits are acting as target qubits. And a $C_2"NOT"$ gate globally performed to correct all data qubits controlled with two ancilla qubits. 


In our assumption, if there is no error, the data qubits and ancilla qubits should keep invariant after applying the pulse sequence. 

If there is an error happens in the middle data qubit 5, different error types(X-error or Z-error) will influence different neighboring ancilla qubits. For example, if an $Z$-error happens in the data qubit 5,  the neighboring ancilla qubits $b$ and $c$ will flip their states. Then, the error-correction process will perform a $C_2"NOT"$ gate on the errored data qubit 5 with the ancilla qubits $b$ and $c$ as control qubits. If the ancilla qubits are in flipped state, the target data qubit can be corrected to the original state. If we assume that the initial state of the ancilla qubits are $|0 angle.r$, the target data qubit will be corrected if the ancilla qubits are in state $|1 angle.r$:

=== Parity-check process
Originally, the parity check process can be performed by using four $"CNOT"$-gate respectively:
#figure(
  image("flip.png", width: 90%),
)
Now, we intend to achieve an one-step parity check process with a multi-qubit gate -- $C_4"NOT"$ gate. However, the one-step $C_4"NOT"$ gate is diffcult to implement in direct. Thus, I intend to perform a Hadamard gate on the ancilla qubit first, then perform a $"CNOT"_4$ gate with the ancilla qubit as control qubit and the data qubits as target qubits. After that, we perform another Hadamard gate on the ancilla qubit to equivalently achieve the $C_4"NOT"$ gate:
#figure(
  image("effect.png", width: 80%),
)

However, when we consider more than one plaquette, there exists the overlapped data qubits which controlled by two ancilla qubits simutaneously. 
#figure(
  image("overlapped.png", width: 100%),
)

Thus, the scheme should be modified to perform a Hadamard gate on the ancilla qubits first, then perform a $"CNOT"_4$ gate with the ancilla qubits as control qubits and the data qubits as target qubits. After that, we perform the $C_2"NOT"$ gate with two ancilla qubits acts as the control qubit and the data qubit is target qubit. Finally, we perform another Hadamard gate on the ancilla qubits to equivalently achieve the $C_4"NOT"$ gate. In order to prove the equivalence, we intend to use 8 qubits for simulation:
#figure(
  image("8qubits.png", width: 45%),
)

=== Simulation of the parity check process
In the simulation of the parity-check process, the energy level of the data qubits and ancilla qubits are shown below:
#figure(
  image("multi-level.png", width: 50%),
)

The number of pulses means that the order of the pulse sequence:
#figure(
  image("pulse_sequence.png", width: 60%),
)

In the pulse shown above, pulse $Omega_P$ and $Omega_R$ are designed to perform the $"CNOT_4"$ gate(1-3 in energy level diagram) and the pulse $Omega_c$ and $Omega_t$ are designed to perform the $C_2"NOT"$ gate(4-6 in energy level diagram).

The Hamiltinian of the system is given by:
$ H_1 = sum Omega_R (|r angle.r_c angle.l 1| + H.c) + Omega_p (|P angle.r angle.l 1| + |P angle.r angle.l 0| + H.c.) $ 
$ H_2 = sum Omega_c (|r angle.r_c angle.l 0| + H.c) + Omega_"t1" (|R angle.r angle.l 1| +  H.c.) 
+ Omega_"t2" (|R angle.r angle.l 0| + H.c.) $

The simulation results are shown below:
When all qubits in state $0$:
#figure(
  image("00000000.jpg", width: 70%),
)

When initial state is $|10101010>$:
#figure(
  image("10101010.png", width: 70%),
)








//The whole process can be divided into two steps. Frome the figure shown above, we assume that an Z-error occurs in the middle data qubit "5". The syndrome information is mapped to the ancilla qubit denoted by red points through the multi-qubit gate. After that, we perform a measurement-free error correction process with the ancilla qubit acting as a control qubit in another multiqubit gate. The error qubit can be corrected by the ancella qubit with syndrome information.

== Why using different atom species?

  Based on the multi-qubit $"CNOT"_k$ gate implementation@photonics10111280, the fidelity is limited by the undesirable interaction between data qubits. Thus, choosing multi-species Rydberg atoms can overcoming these limits by using strong heteronuclear dipole-dipole interactions via Förster resonances for control and target atoms, while the target atoms are coupled by a weaker van der Waals interaction.

  Also, the multi-species Rydberg array can avoid the crosstalk between data qubits and ancilla qubits.



// The desired gate performance is :
// //#figure(
// //  table(
//     columns: 9,
//     [b], [c], [D2], [D3], [D4], [D5], [D6], [D7],[D8],
//     [0], [0], [$0->0$], [$0->0$], [$0->0$], [$0->0$], [$0->0$], [$0->0$],[$0->0$],
//     [0], [1], [$0->0$],  [$0->0$],  [$0->1$],  [$0->1$],  [$0->0$],  [$0->1$],[$0->1$],
//     [1], [0], [$0->1$], [$0->1$], [$0->0$], [$0->1$], [$0->1$], [$0->0$],[$0->0$],
//     [1], [1],[$0->1$], [$0->1$], [$0->1$], [$0->0$], [$0->1$], [$0->1$],[$0->1$]
//   )
// ) 

== Pulse sequence
The pulse sequence is shown below:
#figure(canvas({
  import draw: *
  let y1 = 0.0
  let y2 = -1.0
  let y3 = -2.0

  let xlabel = 0.0
  let width = 0.45
  let height = 0.8
  let dx = 1.0
  let W = 7

  let s(it) = text(9pt)[#it]
  let pulse(x, y, label, color) = {
    rect((x - width/2, y), (x + width/2, y + height), fill: color, stroke: none)
    content((x, y + height/2), label)
  }
  content((0.0, y1), [D])
  content((0.0, y2), [A1])
  content((0.0, y3), [A2])

  rect((1.3 * dx, y1 + height + 0.2), (4.2 * dx, y3 - 0.2), fill: gray.transparentize(60%), stroke: none, radius: 0.1)
  content((2.8 * dx, y3 - 0.5), s[$"CZ"_4$ gate])

  rect((4.9 * dx, y1 + height + 0.2), (6.5 * dx, y3 - 0.2), fill: gray.transparentize(60%), stroke: none, radius: 0.1)
  content((5.5 * dx, y3 - 0.5), s[$C_2"NOT"$ gate]
  )

  // Hadamard gates
  //pulse(dx, y2, s[$h_1$], red)

  // EIT pulse
  pulse(1.5 * dx, y1, s[$h_D$], yellow)
  pulse(1.5 * dx, y2, s[$b_1$], orange)
  pulse(2 * dx, y1, s[$c_D$], blue)
  pulse(2.5 * dx, y2, s[$b_1$], orange)
  pulse(4 * dx, y1, s[$h_D$], yellow)

  pulse(3 * dx, y2, s[$d_1$], purple)
  pulse(3.5 * dx, y1, s[$e_D$], green)
  pulse(4 * dx, y2, s[$d_1$], purple)

  // Hadamard gates
  //pulse(4.5 * dx, y2, s[$h_1$], red)

  // C2X pulse
  pulse(5.2 * dx, y2, s[$d_1$], purple)
  pulse(5.7 * dx, y1, s[$e_D$], green)
  pulse(6.2 * dx, y2, s[$d_1$], purple)

  // Reset A1
  pulse(6.8 * dx, y2, s[$R_1$], gray)

  set-origin((W, 0))
  line((0.2, y1 + height + 0.3), (0.2, y3 - 0.3), stroke: (dash: "dashed"))

  rect((0.9 * dx, y1 + height + 0.2), (4. * dx, y3 - 0.2), fill: gray.transparentize(60%), stroke: none, radius: 0.1)
  content((2.5 * dx, y3 - 0.5), s[$"CNOT"_4$ gate])

  rect((4.6 * dx, y1 + height + 0.2), (6.4 * dx, y3 - 0.2), fill: gray.transparentize(60%), stroke: none, radius: 0.1)
  content((5.5 * dx, y3 - 0.5), s[$C_2"Z"$ gate])

// Hadamard gates
  pulse(4.3 * dx, y1, s[$h_2$], yellow)

  // Hadamard gates
  pulse(0.6 * dx, y1, s[$h_2$], yellow)

  // Hadamard gates
  pulse(0.6 * dx, y3, s[$h_2$], red.lighten(50%))

  // EIT pulse
  pulse(1.2 * dx, y3, s[$b_2$], orange.lighten(50%))
  pulse(1.7 * dx, y1, s[$c_D$], blue)
  pulse(2.2 * dx, y3, s[$b_2$], orange.lighten(50%))
  pulse(2.7 * dx, y3, s[$d_2$], purple.lighten(50%))

  pulse(3.2 * dx, y1, s[$e_D$], green)
  pulse(3.7 * dx, y3, s[$d_2$], purple.lighten(50%))

  // Hadamard gates
  pulse(4.3 * dx, y3, s[$h_2$], red.lighten(50%))


  // C2Z pulse
  pulse(5 * dx, y1, s[$h_D$], yellow)
  pulse(5 * dx, y3, s[$d_2$], purple.lighten(50%))
  pulse(6 * dx, y1, s[$h_D$], yellow)
  pulse(5.5 * dx, y1, s[$e_D$], green)
  pulse(6 * dx, y3, s[$d_2$], purple.lighten(50%))

  // Reset A1
  pulse(7 * dx, y3, s[$R_2$], gray.lighten(50%))


  // Draw lines
  line((dx/2 - W, y1), (7.5 * dx, y1), stroke: black)
  line((dx/2 - W, y2), (7.5 * dx, y2), stroke: black)
  line((dx/2 - W, y3), (7.5 * dx, y3), stroke: black)

}))

Effect of different pulses
- Pulse $h_D$/$h_1$/$h_2$: act on D/A1/A2, Hadamard gate
- Pulse $b_1$/$b_2$: act on A1/A2, state transition $|1 angle.r arrow.l.r |r angle.r$
- Pulse $c_D$: act on D, if any neighboring A1 or A2 qubit in state $|r angle.r$, state transition $|0 angle.r arrow.l.r |1 angle.r$, otherwise, do nothing. Note: it is a composite pulse, also known as the EIT pulse.
- Pulse $d_1$/$d_2$: act on A1/A2, state transition $|0 angle.r arrow.l.r |r angle.r$
- Pulse $e_D$: act on D, if any neighboring A1 or A2 qubit in state $|r angle.r$, do nothing, otherwise, state transition $|0 angle.r arrow.l.r |1 angle.r$

- Pulse $R_1$/$R_2$: act on A1/A2, state transition $|? angle.r arrow.r |0 angle.r$ (reset)

In the first round of parity check process, the minimum unit is shown below:
#figure(
  image("3species.png", width: 35%),
)

== Dual species architecture

The interaction hamiltonian between control qubit and target qubits is given by: 

$ h_"ct" = C_3(1-3cos^2 theta_"CT")|r angle.r angle.l r| times.circle |R angle.r angle.l R| $

where $C_3 =2pi times 10 "GHz" dot mu m^3$, for target atoms in Rydberg state $|R angle.r$, $C_6 = 2pi times 2036"GHZ" dot mu m^6$

== Error-correcting $C_2"NOT"$ gate construction
In this section, we intend to design a multi-qubit $C_2"NOT"$ gate to correct the error qubit. The two ancilla qubits acts as a control qubit, and the errored data qubit is the target qubit. The model is shown below:
#figure(
  image("2qubitgate.png", width: 95%),
)
In this $C_2"NOT"$ gate model, we assume a unbalanced interaction strength similar to the proposed $"CNOT"_4$ gate. The ancilla qubits(green dots) are control qubits and the errored data qubit(blue dot) is the target qubit. The interaction strength satisfies $V_"dd">>V_"vdws"$, where interactions between atoms of the same species are negligible. The pulse sequence is also shown from (i) to (v). All the pulses can be implemented with square pulse. The gate operation can be understood as follows:

(i) The control qubits are initially in the ground state $|0 angle.r_c$. The first $pi$-pulse (i) can couple it to the Rydberg state $|c angle.r_c$ and the target qubit is unchanged due to the strong dipole-dipole interactions. 

(ii) The control qubits are initially in state $|1 angle.r_c$. The first $pi$-pulse (i) cannot couple the control qubits. Thus, the target qubit can be switched between state $|0 angle.r_t$ and $|1 angle.r_t$ through pulse sequence (ii) to (iv). 
The effect of the error-correction process:
$ 
|0_A 0_A 0_T angle.r -> |0_A 0_A 0_T angle.r\
|0_A 0_A 1_T angle.r -> |0_A 0_A 1_T angle.r\
|0_A 1_A 0_T angle.r -> |0_A 1_A 0_T angle.r\
|0_A 1_A 1_T angle.r -> |0_A 1_A 1_T angle.r\
|1_A 0_A 0_T angle.r -> |1_A 0_A 0_T angle.r\
|1_A 0_A 1_T angle.r -> |1_A 0_A 1_T angle.r\
|1_A 1_A 0_T angle.r -> |1_A 1_A 1_T angle.r\
|1_A 1_A 1_T angle.r -> |1_A 1_A 0_T angle.r
$

= Literature Review
1. Construction of multi-qubit $"CNOT"_k$ gate through EIT:@PhysRevA.96.052320, through optimization of the pulse@kazemi2025multiqubitparitygatesrydberg, through adiabatic pulse design@PhysRevLett.128.120503@photonics10111280 and experimental realization:@PhysRevA.102.042607@PhysRevLett.129.200501; Parity gate construction through specially designed interaction strength@guo2025paritycontrolledgatetwodimensionalneutralatom.

2. Measurement-free fault-tolerant quantum error correction:@Heu_en_2024

3. Mid-circuit correction of correlated phase errors using an array of spectator qubits@Singh2023

4. mesoscopic Rydberg gate based on EIT:@PhysRevLett.128.120503. Experimental realization:@PhysRevA.102.042607@PhysRevLett.129.200501

5. There is a scheme familiar to this work in one plaquette.@photonics10111280









#bibliography("bibliography.bib")

// Create appendix section
//#show: appendices

