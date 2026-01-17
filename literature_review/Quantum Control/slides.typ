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
    title: [Toolkits for shortcuts-to-adiabacity, quantum optimal control, and Reinforcement Learning],
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

== Necessity of active control

- Atomic decoherence and interaction with evnvironment makes it necessary to actively and precisely control quantum systems.

== Three paradigms of quantum control
- Shortcuts to adiabaticity (STA)
-- engineering Hamiltonian to mimic adiabatic dynamics in a short time

- Quantum optimal control (QOC)
-- Treating control as a numerical optimization problem to maximize fidelity

- Reinforcement learning (RL)-based quantum control
-- Learning control policies through trial-and-error interactions with the environment

== Shortcuts to adiabaticity (STA) -- mechanism

- Adiabatic process: system remains in instantaneous eigenstate if Hamiltonian varies slowly enough@PhysRevA.101.062309

- STA: We apply extra control fields to suppress non-adiabatic transitions, allowing fast evolution that mimics adiabatic behavior.@RevModPhys.91.045001
$ H_"total"(t) = H_0(t) + H_"cd"(t) $

- Attention: The extra control fields may be challenging to implement experimentally.@Petiziol2024QuantumCB@PhysRevA.98.043436

== Engines of QOC
- Gradient Ascent Pulse Engineering (GRAPE): small quantum system control.

-- Potential of QOC: high-fidelity control in complex systems where analytical solutions are unavailable.(Well-known Hamiltonian)

-- Drawbacks: Trapping in local minima and computational cost for large systems.

- Chopped Random Basis (CRAB): simplifies the control problem by expanding the control function into a truncated basis of randomized functions (e.g., trigonometric functions with random frequencies) and optimizing only a few coefficients.

#figure(
  image("image.png", width: 100%),
)

== comparison of three quantum control paradigms
#figure(
  image("table.png", width: 100%),
)
== references
#bibliography("ref.bib")

