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

== Reference
#bibliography("ref.bib")

