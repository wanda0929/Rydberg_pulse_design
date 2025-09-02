
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
    title: [Measurement-Free Error Correction in Rydberg atom array],
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
== Quantum error correction and code space
- Code space, redundancy, syndrome, error correction.
#figure(
  image("codespace.png", width: 30%),
)
== Toric code
- Toric code Hamiltonian:
$ H = -sum_s S_s - sum_p P_p $
where $S_s = product_(i in s)Z_i, P_p=product_(j in p) X_j $
#figure(
  image("toriccode.png", width: 60%),
)
- Stabilizer:
- Stabilized: Eigenvalue of all stabilizers is $+1$.

//== Necessity of quantum error correction
//- Example: Performing universal and large-scale quantum computation on neutral-atom array
//-- Required gate error rate for performing useful algorithms: $10^(-10)$.@Gidney_2021@reichardt2025faulttolerantquantumcomputationneutral

//-- Physical gate error rate: $10^(-3)$. @Gidney_2021@reichardt2025faulttolerantquantumcomputationneutral
//laser noise, atomic motion and Rydberg state decay
//atom loss.
// //These algorithms are incredibly fragile. A single bit-flip or phase-flip at the wrong time can cascade and ruin the entire computation. The only known way to run these algorithms is to use QEC to encode one perfect logical qubit into many noisy physical qubits, and constantly correct errors on the physical qubits to protect the logical information.

//Aquiring extreme low physical gate error rate and sufficiently many qubits for redundancy. 

//-- Quantum advantage will dissappear as system size grows. 

//-- Solution: Quantum error correction (QEC) process.@shor1997faulttolerantquantumcomputation@1996@Dennis_2002
//add a figure()
//== How to perform quantum error correction
// - QEC process and Toric code:@Khalifa2021Digital

// #figure(
//   image("toriccode.png", width: 60%),
// )

// #figure(
//   image("errorcorrection.png", width: 60%),
// )
//$ H = -sum_s S_s - sum_p P_p $
//where $S_s = product_(i in s)Z_i, P_p=product_(j in p) X_j $

== Main problem
- Measurement and feedback is time-consuming.
(movement-100$mu$s@Bluvstein_2022@Bluvstein_2023; illuminating and collecting-500$mu$s@Norcia_2023@Graham_2023)
#figure(
   image("errorcorrection.png", width: 60%),
   caption: [quantum error correction process @Khalifa2021Digital]
)
- Alternative: self-correcting quantum code(using Hamiltonian to confine to the ground state)@Yoshida_2011

== Third approach
- Measurement-free error correction scheme@Heu_en_2024: 
#figure(
  image("model2.png", width: 40%),
)
//-- Encoding the logical qubit into multiple physical qubits.  
//-- Performing parity check process to extract the error syndrome.
//-- Correcting the error syndrome with a recovery process.
//- The parity check process can be performed with ancilla qubits as control qubits and data qubits as target qubits.
//- The recovery process can be performed with ancilla qubits as control qubits and data qubits as target qubits.


//== Quantum error correction in Rydberg atom platforms

//- Advantage of QEC in Rydberg atom platforms@Bluvstein_2023:

//-- Scalability

//-- Dynamic Reconfigurability therefore high connectivity.@cong2022hardwareefficientfaulttolerantquantumcomputation

//-- High gate fidelity (over 99.9%)@Evered_2023@Xue_2024 and long coherence time(> 1s)@Bluvstein_2023@ludmir2024modelingsimulatingrydbergatom@Wintersperger_2023.

//-- Long range Rydberg interaction enables flexiable qubit connectivity.

//-- Reconfigurable arrays allow implementing quantum error correction code in parallel.
//== Quantum error correction in Rydberg atom platforms
//- Bottlenecks:
//-- Time consuming Parity-check process @science.aah3752@Bluvstein_2022@Barredo_2018

//-- Long measurement time results in external error rate.@PhysRevA.92.042710

//-- Laser Complexity and Crosstalk.

== Parity-check process is time consuming@Barredo_2018
- Moving to entangling zone $=>$ Gate operation $=>$ Back to storage $=>$ Repeating.
#figure(
  image("flip.png", width: 50%),
)
- Movement is slow! The reported gate time is about 1$mu$s@Levine_2018 and the movement time is about hundreds of $mu$s.@Bluvstein_2022@Bluvstein_2023
//== Measurement process is time time-consuming
//- Moving the ancilla to readout zone (100$mu$s) $=>$ illuminating with focused imaging beam(500 $mu$s) $=>$ collect image

//- The long measurement time will result in external error rate.
//-- Solutions: 

//-- mid-circuit measurements@lis2023midcircuitoperationsusingomgarchitecture@Norcia_2023@Graham_2023

//-- atom cooling during detection@Saffman_2016

//-- measurement-free error correction.@Heu_en_2024@Perlin_2023


== Measurement-free error correction model

- Measurement-free and movement-free: through multi-species Rydberg atom array.
#figure(
  image("threespecies.png", width: 50%),
)
//Three species, interaction strengths, 

//== Step1: Parity-check process
//- no error occurs $=>$ all qubits keep invariant after the effective pulse sequence.
//- X-error $=>$ neighboring ancilla qubit A1(green dots) will flip.
//- Z-error $=>$ neighboring ancilla qubit A2(red dots) will flip.

//#figure(
//  image("flip.png", width: 50%),
//)

== Step1: Movement-free parity-check process
- The one-step parity check process in one plaquette:
-- The effective parity check can be implemented with ancilla qubit as control qubit and data qubit as target qubit.

#figure(
  image("effect.png", width: 45%),
)

- The one-step parity check process in more than one plaquettes:
#figure(
  image("overlapped.png", width: 90%),
)
Modifying the pulse sequence to add a CCNOT gate with neighboring ancilla qubit as control qubit and data qubit as target qubit.

== Designed pulse sequence
- Including $"CNOT"_4$ gate and CCNOT gate:
#figure(
  image("gateimp.png", width: 100%),
)

== Designed pulse sequence
- $"CNOT"_4$ gate implementation:
#figure(
  image("gate1.png", width: 50%),
)
- Control qubit in state $|1 angle.r$ $=>$ target qubit flip: $|0 angle.r$ $<=>$ $-|1 angle.r$.
- Control qubit in state $|0 angle.r$ $=>$ target qubit keep invariant.

== Designed pulse sequence
- CCNOT gate implementation:
#figure(
  image("gate2.png", width: 50%),
)
- Control qubits in state $|1 angle.r$ $=>$ target qubit flip: $|0 angle.r$ $<=>$ $-|1 angle.r$.
- One of ontrol qubit in state $|0 angle.r$ $=>$ target qubit keep invariant.

== Simulation process
- We simulate the nine-atoms unit system with x-axis means time and y-axis means the population of different states with designed julia package:


#figure(
  image("simulation.png", width: 50%),
)

== Hadamard rotation:
- All Hadamard rotation $=>$ Pulse sequence $=>$ population extraction.
- We simulate 9-atom unit while we concentrate on the population of single 5-atom plaquette shown below:
#figure(
  image("extraction.png", width: 35%),
)
== Hadamard rotation:
- When all qubits in state $|0angle.r$, the final state is $|+++++angle.r$
#figure(
  image("plus.png", width: 50%),
)
== Hadamard rotation:
- When data qubits in state $|1angle.r$ and ancilla qubits in state $|0angle.r$, the final state is $|++-++angle.r$.
#figure(
  image("minus.png", width: 50%),
)
== Bottlenecks in step1
- The phase accumulation in the gate schemes will affect the realiablility of the equvalence of parity check process.

- Duration of adiabatic pulse is too long and result in gate infidelity.

- feasibility of the designed gate scheme in large system(experimental perspective)(for example, more than 2 species).

- Physical realization of the toric-code lattice.

== Derivative Removal by Adiabatic Gate

== Step2: Error correcting $C_2"NOT"$ gate
//- For example, if there is a Z-error happens on data qubit 5, the parity check will flip the neighboring red ancilla qubits b,c. Then, we can perform a $C_2"NOT"$ gate for error correction where the two flipped neighboring ancilla qubits act as control qubits and the errored data qubit acts as target qubit.

- Rule: Only if the ancilla qubits are both in state $|1 angle.r$, the target data qubit will be flipped.

//== Step2: Error correcting $C_2"NOT"$ gate
- gate scheme:
#figure(
  image("errorco.png", width: 80%),
)


#bibliography("reference.bib")