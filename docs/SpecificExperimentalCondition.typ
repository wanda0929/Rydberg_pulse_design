#import "@preview/clean-math-paper:0.2.0": *

#let date = datetime.today().display("[month repr:long] [day], [year]")
#show: template.with(
  title: "Real experimental conditions of Rydberg gate",
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
  abstract: [In this note, I intend to investigate the experimental conditions of Rydberg gate based on different gate schemes],
  keywords: ("dual species", "multi-qubit gate", "etc"),
  AMS: ("65M70", "65M12", )
)

= Species of Rydberg atoms
1. In this work, we intend to realize a measurement-free error correction scheme. The model and pulse sequence are shown below:
#figure(
  image("pulsesequence.png", width: 95%),
)
In this model, we determine to use three different atomic species. The data qubit is 87-Rb atom, the ancilla qubit 2 is 133-Cs atom and the ancilla qubit 1 is 85-Rb atom.

= Interactions between atoms
In this work, we assume 3 different atomic species, 87-Rb, 133-Cs and 85-Rb. We will describe the interactions in heternuclear and homonuclear cases.

When discussing the distance between atoms, we should also pay attention to the Le Roy radius($R_"LR"$). When the distance between atoms is smaller than the Le Roy radius, there will be electron cloud overlap, which triggers the exchange interactions, charge transfer, or inelastic collisions. These processes cause decoherence, spectral broadening, or unwanted molecular formation, disrupting quantum operations. Thus, we need to make sure that the distance between atoms is larger than the Le Roy radius to avoid unwanted and uncontrolled short-range effects. 

== Heteronuclear interactions between 87-Rb and 133-Cs

We consider the 133-Cs atom excited to the Rydberg state $|r angle.r_c = |81S_(1\/2), m_j = -1\/2 angle.r$ as control qubit and the 87-Rb atom excited to the Rydberg state $|R angle.r_t = |77S_(1\/2), m_j = 1\/2 angle.r$ as target qubit. Due to the interaction between the two atoms the Rydberg states in both atoms will be coupled to other neighboring state(s) and the most dominant interaction channel and corresponding figure are shown below, with energy defect $delta_F = 2pi times 2"MHz"$, dipole-dipole interaction coefficient $C_3 = 2pi times 10 "GHz"$.
$ |81S_(1\/2), m_j = -1\/2; 77S_(1\/2), m_j = 1\/2 angle.r -> |80P_(1\/2), m_j = 1\/2; 77P_(3\/2), m_j = 3\/2 angle.r  $
#figure(
  image("heteronuclear.png", width: 65%),
)
The Le Roy radius for the heteronuclear interaction is $R_"LR" = 2 "um"$ and the distance is required to be larger than the Le Roy radius, i.e., $d > R_"LR"=2mu m$. The possible leckage channel is shown below:
#figure(
  image("Hetero_leakage.png", width: 100%),
)
== Homonuclear interactions between 87-Rb atoms

The homonuclear interaction between two 87-Rb atoms excited to the Rydberg state $|R angle.r_t = |77S_(1\/2), m_j = 1\/2 angle.r$ amost have no leckage channel. The van der Waals coefficient is $C_6 = 2pi times 2036 "GHz" mu m^6$.
#figure(
  image("homo_leakage.png"), 
)

= X-error correction
We assume that there is a single X error on the center data qubit. The error syndrome will be mapped to the ancilla qubit 1 through a effective $C_4"NOT"$-gate with four data qubits in one plaquette are perform as control qubits and the ancilla qubit 1 in the center of the plaquette is the target qubit. The realization of the effective $C_4"NOT"$-gate is shown in the first dashed black box in the figure shown above. 

Thus, we can concentrate on realizing a $"CNOT"_4$ gate with one control qubit controlling four data qubits. The gate scheme 1 describes the gate model of the $"CNOT"_4$ gate:

1. In the energy level diagram: 

(1) The energy levels of control atom (Cs) are $|0 angle.r_c = |6S_(1\/2), F=4 angle.r$, $|1 angle.r_c = |6S_(1\/2), F=3 angle.r$, $|r angle.r_c = |81S_(1\/2), m_j = -1\/2 angle.r$(with lifetime $tau_c = 548 mu s$). 

(2) The energy level of target atoms(87-Rb) are $|R angle.r_t = |77S_(1\/2), m_j = 1\/2 angle.r$(with lifetime $tau_t = 505 mu s$), $|P angle.r_t = |6P_(3\/2)angle.r$(with lifetime $tau_P = 0.131  mu s$), $|A angle.r_t = |5S_(1\/2), F=1 angle.r$, and $|B angle.r_t = |5S_(1\/2), F=2 angle.r$. 

2. In the coupling process: $Omega_p = Omega_"max" sin^2(pi/T_p (t-T_c))$, $Omega_"max"=Omega_r = 2pi times 50 "MHz"$; $Omega_c = 2.5Omega_"max" = 2pi times 125"MHz"$; and the detuning $Delta = 2pi times 1200 "MHz"$ 

3. The interaction strength: the interaction strength between atoms is denoted by $V_"dd"$ and $V_"vdws"$. We assume that the distance between control and target atoms is $d = 6 "um"$ and the distance between target qubits is $6sqrt(2)$.
#figure(
  image("gatescheme1.png", width: 95%),
)

== Model










#bibliography("bibliography.bib")

// Create appendix section
//#show: appendices

