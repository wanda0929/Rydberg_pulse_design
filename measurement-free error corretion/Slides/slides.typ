#import "@preview/touying:0.6.1": *
#import "lib.typ": *

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
    title: [Measurement-Free Error Correction Via Multi-Qubit Syndrome Gate Encoding],
    subtitle: none, 
    author: [Han Wang],
    date: datetime.today(),
    institution: [HKUST(GZ)],
  ),
)

#title-slide()

//#outline-slide()

// Extract methods
#show strong: alert
== Motivation
- Developing a one-step parity check process with global pulse sequence. 

- The errored qubit can be corrected by the ancilla qubits without measurement.

== Model
- Three different species.
- Parity check: (Z-error in plaquette A2), (X-error in plaquette A1)
- Strong interaction between different species, weak interaction between same species.
#figure(
  image("threespecies.png", width: 49%),
)
== Effective parity-check process
- We intend to perform effective parity-check process with $"CNOT"_4$ gate. 

- target: 

-- no error $->$ all qubits keep invariant after the effective pulse sequence.

-- X-error $->$ neighboring ancilla qubit A1(green dots) will flip.

-- Z-error $->$ neighboring ancilla qubit A2(red dots) will flip.

== Effective parity-check process
- pulse sequence:
#figure(
  image("sequence.png", width: 80%),
)
- Effect of different pulses: 
-- Pulse $h_D$/$h_1$/$h_2$: act on D/A1/A2, Hadamard gate

-- Pulse $b_1$/$b_2$: act on A1/A2, state transition $|1 angle.r arrow.l.r |r angle.r$
-- Pulse $c_D$: act on D, if any neighboring A1 or A2 qubit in state $|r angle.r$, state transition $|0 angle.r arrow.l.r |1 angle.r$, otherwise, do nothing. Note: it is a composite pulse, also known as the EIT pulse.
-- Pulse $d_1$/$d_2$: act on A1/A2, state transition $|0 angle.r arrow.l.r |r angle.r$
-- Pulse $e_D$: act on D, if any neighboring A1 or A2 qubit in state $|r angle.r$, do nothing, otherwise, state transition $|0 angle.r arrow.l.r |1 angle.r$

-- Pulse $R_1$/$R_2$: act on A1/A2, state transition $|? angle.r arrow.r |0 angle.r$ (reset)

== Effective parity-check process
- Based on the rules above, we can perform the simulaton to prove the effectiveness of the parity check process.

== Error correcting $C_2"NOT"$ gate
- For example, if there is a Z-error happens on data qubit 5, the parity check will flip the neighboring red ancilla qubits b,c. Then, we can perform a $C_2"NOT"$ gate for error correction where the two flipped neighboring ancilla qubits act as control qubits and the errored data qubit acts as target qubit.

- Rule: Only if the ancilla qubits are both in state $|1 angle.r$, the target data qubit will be flipped.

== Error correcting $C_2"NOT"$ gate
- gate scheme:
#figure(
  image("c2not.png", width: 80%),
)

== Main problem:
- Hard to construct effective multu-qubit gate for perfect parity check. 

- The entanglement after applying the Hadamard gate is not easy to control. 

- The direct parity check process is not easy to implement. 

== Appendix: Effective parity check
- If we assume that there is only one plaquette in the system, for example, we only consider data qubits 2,3,5,6 and one ancilla qubit b. The effective parity check can be implemented through $"CNOT"_4$ gate and Hadamard gates.

#figure(
  image("circuit.png", width: 29%),
)
- In order to perform the $"CNOT"_4$ gate, we intend to use Rydberg blockade effect and:

-- When ancilla qubit is in state $|0 angle.r$, the data qubits are unchanged.

-- When ancilla qubit is in state $|1 angle.r$, the data qubits are flipped.

- For example: 
#figure(
  image("energy_level.png", width: 33%),
)

== Appendix: Effective parity check
- However, in the real model, we need to consider larger system. Each data qubit is influenced by both neighboring ancilla qubits and each ancilla qubit is influenced by four neighboring data qubits. Thus, after applying a Hadamard gate, the entanglement between data qubits and ancilla qubits is not easy to control.
#figure(
  image("threespecies.png", width: 45%),
)

- Double control considered:
$ |0_c 0_c 0_t angle.r arrow.l.r |0_c 0_c 0_t angle.r  $
$ |0_c 1_c 0_t angle.r arrow.l.r |0_c 1_c 1_t angle.r  $
$ |1_c 0_c 0_t angle.r arrow.l.r |1_c 0_c 1_t angle.r  $
$ |1_c 1_c 0_t angle.r arrow.l.r |1_c 1_c 1_t angle.r  $
== Literature Review


1. Construction of multi-qubit $"CNOT"_k$ gate through EIT:@PhysRevA.96.052320, through optimization of the pulse@kazemi2025multiqubitparitygatesrydberg, through adiabatic pulse design@PhysRevLett.128.120503@photonics10111280 and experimental realization:@PhysRevA.102.042607@PhysRevLett.129.200501; Parity gate construction through specially designed interaction strength@guo2025paritycontrolledgatetwodimensionalneutralatom.

2. Measurement-free fault-tolerant quantum error correction:@Heu_en_2024

3. Mid-circuit correction of correlated phase errors using an array of spectator qubits@Singh2023


== Reference
#bibliography("ref.bib")

