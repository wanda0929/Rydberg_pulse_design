
#import "@preview/touying:0.6.1": *
#import "lib.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/unequivocal-ams:0.1.2": ams-article, theorem, proof

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
    title: [Optical Control of Rydberg Atom Array],
    subtitle: none, 
    author: [Han Wang],
    date: datetime.today(),
    institution: [HKUST(GZ)],
  ),
)




#title-slide()

#outline-slide()

// Extract methods
#show strong: alert
= Main works
== Main works
- Using SLM to generate large-scale neutral atom array with automatic differentiation-based method for flexible adjustment of tweezer locations.
// - Generating an optical tweezer arrays that change smoothly over time with SLM via automatic differentiation-based strategy.

- Designing measurement-free and movement-free quantum error correction protocol in Rydberg atom array platform.
= Neutral atom platform and Rydberg pulse design
== Platforms for quantum computing and simulation
// first slide: overview, 听完报告能得到什么 I this work， I will present two works. 第一个工作一张slide带过，第二个工作多讲一些细节。第一个slide表述我的工作内容，第一个第二个，其中第二个工作要主要讲解。着重介绍关于Rydberg pulse design in QEC。Rydberg atom array 在Rydberg atom pulse design当中有什么意义。为什么用pulse design，什么事pulse design。问题定义完整，前人的工作review完整。
//什么是hologram generation，为什么要做这个东西，这在tweezer array generation当中有什么用，把背景部分阐述清楚。
// 问题展示清楚，背景展示清楚，数据有逻辑性的罗列清楚 Rydberg atoms近期发展，先说做了什么，为什么error correction。error correction的必要性。
// 为什么关注neutral atom array平台，那么我们要去产生这个large scale tweezer array，（提一下最近的Lukin等的工作）
#figure(
  image("platform.png", width: 100%),
)
== Advantage of neutral-atom array platform

//SLM 生成大规模阵列的时候要防止未散射的零级光的干扰。这个时候需要spatial filter来阻挡零级光。这就不可避免的占用物理空间导致阵列当中存在间隙，1055的激光就是用于填充间隙而设计的。
- Long Qubit Coherence Times@f8xg-w57m@semião2025resonatorassistedquantumtransductionsuperconducting.
#figure(
  image("coherencetime.png", width: 60%),
)
== Advantage of neutral-atom array platform

- Strong, Tunable Interactions@RevModPhys.82.2313.
#figure(
  image("interaction.png", width: 60%),
)
- High Gate Fidelity (over ~99.5%)@Evered2023@Ma2023.
- Scalability: offering thousand-scale atomic registers@Manetsch_2025@Chiu_2025.
#figure(
  image("large_array.png", width: 50%),
)
// == Requirement of large-scale neutral atom array
// - Quantum simulation of many-body phases and dynamics. 
== Requirement of large-scale neutral atom array
- Reliable quantum computer building requires correction codes implementation.

-- The Overhead: A single logical qubit with sufficient fault tolerance may require hundreds to thousands of physical qubits.
#figure(
  image("Logical qubit.png", width: 50%),
)

// -- The Goal: We need arrays scaling from $N approx 100$ (NISQ era) to $N > 10,000$ (Fault-Tolerant era)@Preskill_2018.
// #figure(
//   image("NISQ_.png", width: 60%),
// )

// - Many-Body Physics Simulation: Simulating complex quantum phases of matter (e.g., spin liquids) requires lattice sizes that exceed the capabilities of classical supercomputers ($N > 50-100$).

// - Connectivity: Large 2D and 3D arrays allow for nearest-neighbor interactions required for gate operations via Rydberg blockade.
== Large-scale neutral atom array generation
- Method of trapping atoms: We sculpt light using phase modulation. Generating optical tweezers($< 1 mu m$ spots) with highly focused laser beams that hold individual atoms.
#figure(
  image("difffract.png", width: 40%),
)
- Main tools: The Spatial Light Modulator (SLM), a programmable diffractive element, imprints a phase profile $phi(x,y)$ onto the laser beam.

- Algorithm for hologram generation: Calculating the phase pattern $phi(x,y)$ to produce the desired intensity pattern at the focal plane.
#figure(
  image("array.png", width: 60%),
)
== Critical bottlenecks in large array generation

Hindered scalability: preparation and operation latency
- Collisional blockaded effect: (50% loading efficiency)@Fung_2015. 
#figure(
  image("collisional_blockade.png", width: 60%),
)

== Requirements for large-scale neutral atom array generation
- Requiring rearrangement with fast, flexible dynamic control and least computation cost. 

-- Previous works@aah3752: rearranging atoms with acousto-optic deflectors (AODs).

#figure(
  image("rearrange.png", width: 29%),
)


// = Dynamic Array Generation //via Automatic Differentiation
== Dynamic Array Generation via Automatic Differentiation
//相比之前的方法，AD-based method有以下优点，包括可以更加灵活的生成想要的阵列形状，可以更加高效的计算phase pattern，并且相对neural network-based method有更好的数值稳定性和可解释性。
- high efficiency, better explainability and better numerical stability.
#figure(
  image("difffract.png", width: 55%),
)
== Dynamic Array Generation via Automatic Differentiation
- Algorithm for calculating the the hologram displayed on SLM: 
#figure(
  image("ad_evolve.png", width: 60%),
)
// knowing the locations of two continuous timesteps; calculating the hologram phase pattern of the previous timestep with C_WGS; calculating the velocity of the moving dots; calculating the phase-change velocity with AD(implicit differentiation); Evolve and update the phase dynamics.
// == Dynamic Array Generation via Automatic Differentiation
// - The AD-based method treats the phase-coordinate relationship as an analytic function
== Critical bottlenecks in large array generation
- After the preparation stage, movement and measurement of atoms during quantum operations is time-consuming: (hundreds of $mu$s)@Bluvstein_2023@Graham_2023.
#figure(
  image("timeconsuming.png", width: 60%),
)
== Measurement-free and movement-free protocol
-- Using static atoms of two species and applying global pulse sequences for implementing @Anand2024. 
#figure(
  image("dualspecies.png", width: 60%),
)
= A Protocol to Eliminate Measurement Latency
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


== Measurement-free and movement-free error correction model
- Toric code space with periodic boundary condition.
- Neutral atom array with three different species: ancilla qubits(A1, A2) for Z/X-error check/correction and data qubits(D).
#figure(
  image("basic_array.png", width: 27%),
)
//Three species, interaction strengths, 

//== Step1: Parity-check process
//- no error occurs $=>$ all qubits keep invariant after the effective pulse sequence.
//- X-error $=>$ neighboring ancilla qubit A1(green dots) will flip.
//- Z-error $=>$ neighboring ancilla qubit A2(red dots) will flip.

//#figure(
//  image("flip.png", width: 50%),
//)

== Movement-free parity-check process
- The one-step parity check process in one plaquette:
-- The effective parity check can be implemented with ancilla qubit as control qubit and data qubit as target qubit.

#figure(
  image("effect.png", width: 45%),
)

- Implementation Constraint: Each data qubit is controlled by two neighboring ancilla qubits simultaneously.
#figure(
  image("overlapped_2.png", width: 90%),
)

Solution: Modifying the pulse sequence to add a CCNOT gate with neighboring ancilla qubit as control qubit and data qubit as target qubit.

== Measurement-free and movement-free error correction model
#figure(
  image("model5.png", width: 70%),
)

== Designed pulse sequence for X-error parity check
#figure(
  image("model44.png", width: 70%),
)
- Including or-gate and CCNOT gate:
#figure(
  image("gateimp1.png", width: 100%),
)
= Different simulation methods(Pulse-level vs QCA vs MPS)

// == Designed pulse sequence for Z-error check
// - $"CNOT"_4$ gate implementation:
// #figure(
//   image("gate1.png", width: 50%),
// )
// - Control qubit in state $|1 angle.r$ $=>$ target qubit flip: $|0 angle.r$ $<=>$ $-|1 angle.r$.
// - Control qubit in state $|0 angle.r$ $=>$ target qubit keep invariant.

// == Designed pulse sequence
// - CCNOT gate implementation:
// #figure(
//   image("gate2.png", width: 50%),
// )
// - Control qubits in state $|1 angle.r$ $=>$ target qubit flip: $|0 angle.r$ $<=>$ $-|1 angle.r$.
// - One of ontrol qubit in state $|0 angle.r$ $=>$ target qubit keep invariant.

// == Simulation results for Z-error parity check
// // - We simulate the nine-atoms unit system with x-axis means time and y-axis means the population of different states with designed julia package:


// // #figure(
// //   image("simulation.png", width: 50%),
// // )
// - All Hadamard rotation $=>$ Pulse sequence $=>$ All Hadamard rotation.
// - Concentrate on the population of single 5-atom plaquette shown below:
// #figure(
//   image("extraction.png", width: 35%),
// )
== Simulation results for X-error parity check--no error
// - $|00000angle.r => |"+++++"angle.r =>"pulse sequence" => |"+++++"angle.r => |00000 angle.r ("final state")$
#figure(
  image("noerror.png", width: 37%),
)
// == Simulation results for X-error parity check--no error
// - $|11011angle.r => |"--+--"angle.r =>"pulse sequence" => |"--+--"angle.r => |11011 angle.r ("final state")$
// #figure(
  // image("minus2.png", width: 50%),
// )
== Simulation results for X-error parity check--single error
// - $|10000angle.r => |"-++++"angle.r =>"pulse sequence" => |"-+-++"angle.r => |10100 angle.r ("final state")$
#figure(
  image("error.png", width: 37%),
)

== Simulation results for X-error parity check--single error
- $|00000 angle.r -> |00000 angle.r$, Fidelity = 0.9979
- $|10000 angle.r -> |10100 angle.r$, Fidelity = 0.9979
- $|01011 angle.r -> |01111 angle.r$, Fidelity = 0.9989
- $|11011 angle.r -> |11011 angle.r$, Fidelity = 0.9996

== Bottlenecks in pulse-level simulation
- The Scalability Bottleneck: Exponential growth of Hilbert space size with increasing atom number.

- We need scalable alternatives that preserve key physics.

- Two paths to scalability:

-- quantum cellular automata (QCA) approach 

-- Tensor Networks (Matrix Product States, MPS)

== Quantum cellular automata approach
- Approach: Discretization

- Abstracts continuous evolution into discrete, local update rules. Perfect for studying logical error propagation and topological thresholds on massive lattices.
#figure(
  image("qca.png", width: 45%),
  caption: [Qubits are represented by the colored boxes, while the three-qubit local rules derived from pulse-level physics are represented by the black rectangles.]
)

// == Discrete update rules
// #figure(
//   image("rules.png", width: 60%),
//   caption: [Local update rules for the QCA model of the measurement-free error correction protocol.]
// )
== Bottlenecks in QCA approach
- QCA:
-- QCA relies on simplified discrete rules rather than continuous quantum dynamics. Loss of details.

--  storing the dense vector ($2^N$ amplitudes)

- Tensor network: 
-- Objective: To simulate large-scale arrays while retaining the full quantum mechanical description of the state vector $|psi angle.r$.


== Simulation results with QCA

== Tensor Networks (MPS)
- Approach: Compression

- Mechanism:
-- Decomposes the global state into a chain of local tensors connected by virtual bonds.

-- Mappings: Uses a "snake" ordering path to map 2D atom arrays to 1D MPS structures.
// Retains the full wavefunction but compresses it based on entanglement entropy ("Area Law"). Ideal for high-fidelity simulation of intermediate-scale systems (50-100 atoms).
// Exploits the "area law" of entanglement entropy. As long as entanglement is limited (which is true for stabilizer/ground states), the state can be compressed efficiently without losing quantum information
// #figure(
//   image("mps.png", width: 40%),
//   caption: [Matrix Product State representation of a quantum state.]
// )

// == Simulation with MPS
// - Mapping the 2D lattice to a 1D chain.
#figure(
  image("MPS-32.png", width: 60%),
  caption: [Mapping the 2D lattice to a 1D chain for MPS simulation.]
)

-- MPO construction of the pulse sequence.

-- Contraction and Truncation to control bond dimension.
// == Simulation results for X-error parity check--single error
// - $|01011angle.r => |"+-+--"angle.r =>"pulse sequence" => |"+++++"angle.r => |00000 angle.r ("final state")$
// #figure(
//   image("allmflip1.png", width: 50%),
// )


// == Bottlenecks in step1
// - The phase accumulation in the gate schemes will affect the realiablility of the equvalence of parity check process.

// - Duration of adiabatic pulse is too long and result in gate infidelity.

// - feasibility of the designed gate scheme in large system(experimental perspective)(for example, more than 2 species).

// - Physical realization of the toric-code lattice.

// == Derivative Removal by Adiabatic Gate
// - DRAG
// == Step2: Error correcting $C_2"NOT"$ gate
// //- For example, if there is a Z-error happens on data qubit 5, the parity check will flip the neighboring red ancilla qubits b,c. Then, we can perform a $C_2"NOT"$ gate for error correction where the two flipped neighboring ancilla qubits act as control qubits and the errored data qubit acts as target qubit.

// - Rule: Only if the ancilla qubits are both in state $|1 angle.r$, the target data qubit will be flipped.

// //== Step2: Error correcting $C_2"NOT"$ gate
// - gate scheme:
// #figure(
//   image("errorco.png", width: 80%),
// )

== bibliography
#bibliography("reference.bib")