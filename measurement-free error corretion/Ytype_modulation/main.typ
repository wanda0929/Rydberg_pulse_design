#import "@preview/clean-math-paper:0.2.0": *
#import "@preview/cetz:0.3.2": canvas, draw, tree, vector, decorations

#let date = datetime.today().display("[month repr:long] [day], [year]")
#show: template.with(
  title: "Shortcut to adiabatic population transfer in quantum three-level systems: Effective two-level problems and feasible counterdiabatic driving",
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
  abstract: [In this note, I intend to change the pulse shape of $Omega_p$ in Y-type energy level systems and see that if the laser pulse can be optimized],
  keywords: ("measurement-free error correction", "multi-species array", "parity-gate", "multi-qubit gate", "etc"),
  AMS: ("65M70", "65M12", )
)
== Introduction
In this section, the original pulse sequence for Y-type system is shown below:
#figure(
  image("laser_sequence.png", width: 60%),
)
It is obvious that the pulse duration of $Omega_p$ is much longer than other pulses, which will induce decay error and decoherence. Thus, we intend to speed up the pulse $Omega_p$.

Initially, we try to use DRAG method to eliminate the leakage to intermediate state. However, during the investigation process, I found that the DRAG method in Rydberg atom system is mainly targeted at decreasing the leakage to nearby Rydberg states and most relevant papers are focusing on two-level systems. 

Thus, I try to use the counterdiabatic driving method to speed up the adiabatic process. 

There are mainly two different conditions: the first is transition-blocking process: I concentrate on the EIT process considering ground state $|0>, |1>$, intermediate state $|p>$ and Rydberg state $|r>$. In this process, there are mainly two different ways to transition-blocking process: 1)Use adiabatic driving to maintain the system in the dark state; 2)Use counterdiabatic driving to cancel the non-adiabatic transition.(This is still under investigation)

The second is population-transfer process with Raman laser. In this case, we cannot use counterdiabatic driving to compensate the non-adiabatic transition directly since the two coupling lasers($Omega_p$) are of same pulse shape. So, we use the effective two-level model to couple two ground states $|0>, |1>$. The effective coupling strength is $Omega_"eff" = Omega_p^2/(2*Delta)$ and the effective detuning is $Delta_"eff" = 0$. The pulse area of $Omega_"eff"$ should be $pi$ to realize the population transfer. 

We first changed the pulse shape of $Omega_p$ to Gaussian shape to see the results:
== Simulation
The new pulse shape is shown below:
#figure(
  image("pulse.png", width: 60%),
)

When control qubit is in state $|0>$, target qubit is invariant:
#figure(
  image("00-01.png", width: 60%),
)

When control qubit is in state $|1>$, target qubit is transferred from $|0>$ to $|1>$:
#figure(
  image("10-11.png", width: 60%),
)

