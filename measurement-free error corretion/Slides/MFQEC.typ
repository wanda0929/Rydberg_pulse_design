
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
== Necessity of quantum error correction
- Example: Performing quantum simulation on a large neutral-atom array
-- Required gate error rate for performing useful algorithms: $10^(-10)$.

-- Physical gate error rate: $10^(-3)$. @Gidney_2021

//Aquiring extreme low physical gate error rate and sufficiently many qubits for redundancy. 

-- Quantum advantage will dissappear as system size grows. 

-- Solution: Quantum error correction (QEC) process.@shor1997faulttolerantquantumcomputation@1996@Dennis_2002

== Quantum error correction in Rydberg atom platforms

- Advantage of QEC in Rydberg atom platforms@Bluvstein_2023:
-- Long range Rydberg interaction enables flexiable qubit connectivity.

-- Reconfigurable arrays allow implementing quantum error correction code in parallel.@cong2022hardwareefficientfaulttolerantquantumcomputation

- Bottlenecks:
-- Parity-check process: Performing sequential two-qubit gates requires time-consuming atom movement steps. @science.aah3752@Bluvstein_2022@Barredo_2018

-- Measurement process: measurement time is much longer than other gate times and the external crosstalk error rate(due to scattering of light).@PhysRevA.92.042710

== Parity-check process is time consuming@Barredo_2018
- Moving to entangling zone $=>$ Gate operation $=>$ Back to storage $=>$ Repeating.
- The reported gate time is about 1$mu$s@Levine_2018 and the movement time is about hundreds of $mu$s.@Bluvstein_2022@Bluvstein_2023

#figure(
  image("paritycheck.png", width: 50%),
)

== Measurement process is time time-consuming
- Moving the ancilla to readout zone (100$mu$s) $=>$ illuminating with focused imaging beam(500 $mu$s) $=>$ collect image

- The long measurement time will result in external error rate.
-- Solutions: 

-- mid-circuit measurements@lis2023midcircuitoperationsusingomgarchitecture@Norcia_2023@Graham_2023

-- atom cooling during detection@Saffman_2016

-- measurement-free error correction.@Heu_en_2024@Perlin_2023


== Measurement-free error correction model

- The measurement-free error correction model in Toric code space:
#figure(
  image("threespecies.png", width: 50%),
)
//Three species, interaction strengths, 

== Step1: Parity-check process
- no error occurs $=>$ all qubits keep invariant after the effective pulse sequence.
- X-error $=>$ neighboring ancilla qubit A1(green dots) will flip.
- Z-error $=>$ neighboring ancilla qubit A2(red dots) will flip.

#figure(
  image("flip.png", width: 50%),
)

== Step1: Parity-check process
- The one-step parity check process in one plaquette:
-- The effective parity check can be implemented with ancilla qubit as control qubit and data qubit as target qubit.

#figure(
  image("effect.png", width: 47%),
)

- The one-step parity check process in more than one plaquettes:
#figure(
  image("overlapped.png", width: 90%),
)
Modifying the pulse sequence to add a $C_2$NOT gate with neighboring ancilla qubit as control qubit and data qubit as target qubit.

== Designed pulse sequence
- Including $"CNOT"_4$ gate and $C_2$NOT gate:
#figure(
  image("gateimpl.png", width: 100%),
)
== Bottlenecks in step1
- The equivalence of the pulse sequence of effective parity check process cannot be guaranteed.

- feasibility of the designed gate scheme in large system(experimental perspective)(for example, more than 2 species).




== Step2: Error correcting $C_2"NOT"$ gate
//- For example, if there is a Z-error happens on data qubit 5, the parity check will flip the neighboring red ancilla qubits b,c. Then, we can perform a $C_2"NOT"$ gate for error correction where the two flipped neighboring ancilla qubits act as control qubits and the errored data qubit acts as target qubit.

- Rule: Only if the ancilla qubits are both in state $|1 angle.r$, the target data qubit will be flipped.

//== Step2: Error correcting $C_2"NOT"$ gate
- gate scheme:
#figure(
  image("errorco.png", width: 80%),
)


#bibliography("reference.bib")