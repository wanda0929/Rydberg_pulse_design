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
  abstract: [Logical qubits can be protected from decoherence by performing quantum error correction. Naturally, the QEC algorithm requires feedback process to specific hardware platform which takes more time and cause extra error and the syndrome generation process requires movement of atoms which also takes much time. In our scheme, we intend to develop a measurement-free and movement-free error correction scheme based on Toric code space@Khalifa2021Digital. With individually addressable, optically trapped, multi-species Rydberg atoms@Bluvstein_2023, we perform the multiqubit parity gates to generate syndromes and design a error-correction process without measurement feedback.],
  keywords: ("measurement-free error correction", "multi-species array", "parity-gate", "multi-qubit gate", "etc"),
  AMS: ("65M70", "65M12", )
)

= Motivation
1. In order to eliminate the time required for quantum error correction process, we intend to develop a parity-controlled multiqubit gate to perform one-step syndrome mapping from data qubits to ancilla qubit with global pulse sequence without movement of atoms which takes much time. 

2. After the syndrome generation process, there is a state-flip in the ancilla qubit state if there is an error in data qubits. We will apply another pulse sequence to manipulate a $C_2$NOT gate to fix the error qubit. Thus, we do not need to perform measurement on the ancilla qubit.

== Introduction
=== Necessity of quantum error correction

The required gate error rate for performing useful algorithms is $10^(-10)$@Gidney_2021@reichardt2025faulttolerantquantumcomputationneutral while the physical gate error rate in neutral-atom array is $10^(-3)$@Gidney_2021@reichardt2025faulttolerantquantumcomputationneutral. The physical gate error rate is much larger than the required gate error rate for performing useful algorithms. Thus, we need to perform quantum error correction@shor1997faulttolerantquantumcomputation@1996@Dennis_2002 to protect the logical information from decoherence and errors.

=== Quantum error correction
Nowadays, performing quantum error correction in neutral atom system is attracting much attention because of the scability, reconfigurability, high connectivity@cong2022hardwareefficientfaulttolerantquantumcomputation, and high gate fidelity (over 99.9%) @Evered_2023@Xue_2024 and long coherence time(> 1s)@Bluvstein_2023@ludmir2024modelingsimulatingrydbergatom@Wintersperger_2023.

In quantum error correction@Khalifa2021Digital, we first encode the logical qubit into multiple physical qubits. The redundancy can protect the logical information from decoherence and errors. Then, we perform a syndrome generation process and we use a definition called stabilizer which is a set of operators that can be used to detect errors without disturbing the quantum state to generate syndromes. Then, we measure the syndrome and perform the decoding process. Finally, we perform an error-correction process to correct the errored data qubit. 

However, the tradition quantum error correction process requires measurement and feedback process which is time-consuming(movement-100$mu$s@Bluvstein_2022@Bluvstein_2023; illuminating and collecting-500$mu$s@Norcia_2023@Graham_2023) and can introduce extra error(for example, measurement might result in atom loss)@PhysRevA.92.042710.

According to this problem, there are many schemes like self-correcting quantum code(using Hamiltonian to confine to the ground state)@Yoshida_2011 and Measurement-free error correction scheme@Heu_en_2024. However, the measurement-free error correction scheme in ref.@Heu_en_2024 is still time-consuming because it requires moving atoms to entangling zone and perform gate operation one by one in parity check process(The reported gate time is about 1$mu$s@Levine_2018 and the movement time is about hundreds of $mu$s.@Bluvstein_2022@Bluvstein_2023).

In this way, we intend to develop a measurement-free error correction scheme based on Toric code space. With individually addressable, optically trapped, multi-species Rydberg atoms, we perform the movement-free multiqubit parity gates to generate syndromes and design a error-correction process without measurement feedback.




= Model(Overview)

The figure shown below is the measurement-free error correction model in toric code space. There are totally three species of atoms with green and red dots represent ancilla qubits and the blue dots represents the data qubits. 
#figure(
  image("threespecies.png", width: 40%),
)
In the model shown above, we intend to perform an parity gate where data qubits are control qubits and the ancilla qubit is the target qubit. If an Z error occurs in the data qubit, the ancilla qubit in corresponding plaquette(red dots) will flip. If an X error occurs in the data qubit the green dots will flip. Then, we intend to perform a $C_2"NOT"$ gate where the ancilla qubits acts as control qubits, and the errored data qubit is the target qubit. The $C_2"NOT"$ gate will correct the errored qubit without measuring process. 

== Interactions between atoms
In this multi-qubit platform, we intend a strong dipole-dipole interaction between different atom species and weak van der Waals interaction between atoms of the same species. ($V_"dd">>V_"vdws"$), where interactions between atoms of the same species are negligible. It largely reduces the error caused by undesirable interactions between data qubits and crosstalk between data qubits and ancilla qubits.
== Why using different atom species?
Based on the multi-qubit $"CNOT"_k$ gate implementation@photonics10111280, the fidelity is limited by the undesirable interaction between data qubits. Thus, choosing multi-species Rydberg atoms can overcoming these limits by using strong heteronuclear dipole-dipole interactions via Förster resonances for control and target atoms, while the target atoms are coupled by a weaker van der Waals interaction.

  Also, the multi-species Rydberg array can avoid the crosstalk between data qubits and ancilla qubits.

== Effective parity check and error-correction

In our assumption, if there is no error, the data qubits and ancilla qubits should keep invariant after applying the pulse sequence. 

For example, if there is an error happens in the middle data qubit 5, different error types(X-error or Z-error) will influence different neighboring ancilla qubits. For example, if an $Z$-error happens in the data qubit 5,  the neighboring ancilla qubits $b$ and $c$ will flip their states. Then, the error-correction process will perform a $C_2"NOT"$ gate on the errored data qubit 5 with the ancilla qubits $b$ and $c$ as control qubits. If the ancilla qubits are in flipped state, the target data qubit can be corrected to the original state. If we assume that the initial state of the ancilla qubits are $|0 angle.r$, the target data qubit will be corrected if the ancilla qubits are in state $|1 angle.r$:

=== Parity-check process
Originally, the parity check process can be performed by using four $"CNOT"$-gate respectively in one plaquette. For more than one plaquette, the CNOT gate will be performed in order:
#figure(
  image("flip.png", width: 90%),
)
Now, we intend to achieve an one-step parity check process in the whole system with a global pulse sequence applied to the whole system. where the data qubits are control qubits and the ancilla qubits are target qubits. However, the direct parity-gate implementation is hard. We intend to equivalently achieve the parity check process through Hadamard gate and multi-qubit gate where the data qubits are acts as target qubits and the ancilla qubits acts as control qubits. 
#figure(
  image("effect.png", width: 80%),
)
When considering only one plaquette, the Hadamard gate can be applied to all data qubits in the beginning and in the end of the pulse sequence. Then, we perform a $"CNOT"_4$ gate with the ancilla qubits as control qubits and the data qubits as target qubits. Finally, we perform another Hadamard gate on all qubits to equivalently achieve the $C_4"NOT"$ gate.

However, when we consider more than one plaquette,see the figure shown below, there exists an overlapped data qubits 5. In general syndrome generation process, the multi-qubit gate will be performed in order, which means that the overlapped data qubit 5 will be applied control qubit twice. If two ancilla b and c are in state $|1 angle.r$, the data qubit 5 will be flipped twice, which means that the data qubit 5 will be flipped back to the original state. 
#figure(
  image("overlapped.png", width: 100%),
)
However, in our scheme, we intend to perform the multi-qubit gate with global pulse sequence in one step. Thus, the overlapped data qubit 5 will be controlled by two ancilla qubits at the same time. if both ancilla qubits are in state $|1 angle.r$, the data qubit 5 will be flipped once, which means that the global pulse sequence will not achieve the desired parity check process.

In this way, we intend to flip the unflipped data qubit 5 with an external multiqubit gate followed the previous control gate with ancilla qubits as control qubits and overlapped data qubits as target qubits in parallel. 

In order to prove the equivalence, we intend to use 8 qubits for simulation:
#figure(
  image("8qubits.png", width: 45%),
)

=== Simulation of the parity check process
1. First gate implementation
#figure(
  image("gate1.png", width: 70%),
)
In the first gate implementation, we take one plaquette as the minimum unit. When the control qubit initially in state $|0 angle.r_c$, the Hamiltonian of target qubits is given by:
$ H_1 = Omega_c (|r angle.r_j angle.l P| + H.c) + Omega_p (t) (|P angle.r_j angle.l 1| + |P angle.r_j angle.l 0| + H.c.) + Delta |P angle.r_j angle.l P| $ 

$ H_c = Omega_r (|r angle.r_c angle.l 1| + H.c.) $

$ H_"total"= H_1 + H_c + V_"dd"|"rR" angle.r angle.l "rR"| $

Under the condition $Delta>>Omega_c, Omega_p$, the intermediate state $|P angle.r$ can be adiabatically eliminated. Pulse $Omega_c$ is constant and $Omega_p$ is an adiabatic pulse with $integral Omega_p (t)^2\/(2Delta) = pi$. The system contains two dark states with
$ |D_1 angle.r = 1/sqrt(2) (|0 angle.r - |1 angle.r) $
$ |D_2 angle.r = Omega_c\/sqrt(Omega_c^2 + 2Omega_p^2) [(|0 angle.r + |1 angle.r)/sqrt(2) - sqrt(2)Omega_p\/Omega_c |r angle.r] $ The initial state of the system is in the random states of $|Psi angle.r = alpha|D_1 angle.r + beta|D_2 angle.r$, the state will not change after the whole evolution.

However, when the control qubit is in state $|1 angle.r_c$, the Hamiltonian of target qubits is given by:
$ H_2 = H_1 + sum_j V_"dd" |r angle.r_j angle.l r| $
because of the strong interaction between control qubit and target qubits. $V>Omega_c^2\/4Delta$ will break the EIT condition and the target qubits will go flip through Ranman $pi$-pulse.

2. Second gate implementation
#figure(
  image("gate2.png", width: 70%),
)
In the second gate implementation, we take overlapped qubit and neighboring ancilla qubits as the minimum unit. When control qubit initially in state $|1 angle.r_c$, the Hamiltonian of target qubits is given by:
$ H_t = Omega_"t1" (|R angle.r angle.l 1| +  H.c.) 
+ Omega_"t2" (|R angle.r angle.l 0| + H.c.) $ 
There is a state flip on target qubits. However, when the control qubit is in state $|0 angle.r_c$, it will be coupled to the Rydberg state $|R angle.r_c$ and the target qubit will not flip because of the Rydberg blockade effect.

3. Now comes to the simulation under the pulse sequence including gate 1 and gate 2:
#figure(
  image("multi-level.png", width: 50%),
)

The number of pulses means that the order of the pulse sequence:
#figure(
  image("pulse_sequence.png", width: 60%),
)

In the pulse shown above, pulse $Omega_P$ and $Omega_R$ are designed to perform  gate1 (1-3 in energy level diagram) and the pulse $Omega_c$ and $Omega_t$ are designed to perform the gate2(4-6 in energy level diagram).

The simulation results are shown below:
When all qubits in state $0$:
#figure(
  image("00000000.jpg", width: 60%),
)

// When initial state is $|10101010>$:
// #figure(
//   image("10101010.png", width: 70%),
// )

// When initial state is $|11111111>$:
// #figure(
//   image("11111111.png", width: 70%),
// )

When initial state is $|01010101>$:
#figure(
  image("01010101.jpg", width: 70%),
)
However, when we apply the Hadamard gate on all qubits, the final state cannot return to the original state. The final state is shown below:
#figure(
  image("hh1.png", width: 60%),
)

#text(red)[Problem: How to determine the minimum simulation unit? If we assume that the minimum unit is one plaquette, the simulation is not accurate because we do not take the overlapped data qubit into consideration. 

If we assume that the minimum unit is two plaquettes, the simulation requires too much time

If we assume that the minimum unit is eight qubits shown above, it is hard to analyse the simulation behavior because it does not contains a whole plaquette for us to analyse the simulation behavior.

It is illustrated in ref.@Heu_en_2024 that the multi-qubit gates mostly are not suffucient for performing error correction if the fidelity is lower than the threshold of certain codes.]

== Changing the minimum simulation unit

 In this section, I changed the minimum simulation to a new unit shown below:
 #figure(
   image("newunit.png", width: 60%),
 )

If the data qubits and the ancilla qubits initially in state 0, the control pulses 1,3 are useless, the pulse2 and constanct laser $Omega_c$ will not change the state of the data qubits. After this process, pulse 4 will couple the ancilla qubit to the Rydberg state and pulse 5, 6, 7 will be useless. The state of data qubit will keep invariant. Finally, pulse 8 will bring the ancilla qubit back to the ground state 0.

#figure(
  image("all00.png", width: 60%),
)

If the data qubits in state 1 and ancilla qubits in state 0, the ancilla qubit will undergo a similar process and the data qubits will stay in state1. 

#figure(
  image("data1anc0.png", width: 60%),
)

Now, I intend to apply Hadamard gate on all qubits in the beginning and in the end of the pulse sequence to equivalently achieve the parity check process.

The timesequence is shown below:
#figure(
  image("laser.png", width: 60%),
)


When we apply the Hadamard gate on all qubits, the system cannot return to the original state:
#figure(
  image("Hadanore.png", width: 60%),
)
In order to analyse the cause of the problem, we set adiabatic pulse $Omega_p$ to be zero, and the state population is:
#figure(
  image("noomegap.png", width: 60%),
)
Thus, the main problem lies in the adiabatic pulse $Omega_p$.

We take a step-by-step check on the pulse sequence, and we take 3-atom system as an example including two ancilla qubits and one data qubit.
1. initially, the system is in state $|000 angle.r$, we apply Hadamard gate on all qubits and we apply the first pulse $Omega_r$:
#figure(
  image("hada1.png", width: 40%),
)
#figure(
  image("hada2.png", width: 40%),
)
In this process, the ancilla qubits are converted from state $|+ angle.r$ to state $|A angle.r = (|0 angle.r - im*|r angle.r)/sqrt(2)$. 

2. Then, we apply the second pulse $Omega_p$ and the third pulse $Omega_r$:
If one of the ancilla is in state $|1 angle.r$, the data qubits will achieve a state transition from $|0 angle.r => -|1 angle.r$ or $|1 angle.r => -|0 angle.r$. 

If the input state is $|+_A+_T+_A angle.r$, the output state will be:
$ 
|0_A 0_T 0_A angle.r ->   |0_A 0_T 0_A angle.r\
|0_A 0_T 1_A angle.r -> - |0_A 1_T 1_A angle.r\
|0_A 1_T 0_A angle.r ->   |0_A 1_T 0_A angle.r\
|0_A 1_T 1_A angle.r -> - |0_A 0_T 1_A angle.r\
|1_A 0_T 0_A angle.r -> - |1_A 1_T 0_A angle.r\
|1_A 0_T 1_A angle.r -> - |1_A 1_T 1_A angle.r\
|1_A 1_T 0_A angle.r -> - |1_A 0_T 0_A angle.r\
|1_A 1_T 1_A angle.r -> - |1_A 0_T 1_A angle.r
$


If the input state is $|+_A-_T+_A angle.r$, the output state will be 
$ 
|0_A 0_T 0_A angle.r ->   |0_A 0_T 0_A angle.r\
|0_A 0_T 1_A angle.r -> - |0_A 1_T 1_A angle.r\
-|0_A 1_T 0_A angle.r -> - |0_A 1_T 0_A angle.r\
-|0_A 1_T 1_A angle.r ->   |0_A 0_T 1_A angle.r\
|1_A 0_T 0_A angle.r -> - |1_A 1_T 0_A angle.r\
|1_A 0_T 1_A angle.r -> - |1_A 1_T 1_A angle.r\
-|1_A 1_T 0_A angle.r ->  |1_A 0_T 0_A angle.r\
-|1_A 1_T 1_A angle.r ->  |1_A 0_T 1_A angle.r
$


3. In the $C_2"NOT"$ gate process, the control pulse $Omega_c$ will bring a phase $-"im*r"$. The pulse on the data qubits will bring no phase accumulation. 

If the input state is $|+_A-_T+_A angle.r$, the output state will be changed.
$ 
|0_A 0_T 0_A angle.r ->   |0_A 0_T 0_A angle.r ->   |0_A 0_T 0_A angle.r\
|0_A 0_T 1_A angle.r -> - |0_A 1_T 1_A angle.r-> - |0_A 1_T 1_A angle.r\
-|0_A 1_T 0_A angle.r -> - |0_A 1_T 0_A angle.r-> - |0_A 1_T 0_A angle.r\
-|0_A 1_T 1_A angle.r ->   |0_A 0_T 1_A angle.r->   |0_A 0_T 1_A angle.r\
|1_A 0_T 0_A angle.r -> - |1_A 1_T 0_A angle.r-> - |1_A 1_T 0_A angle.r\
|1_A 0_T 1_A angle.r -> - |1_A 1_T 1_A angle.r-> - |1_A 0_T 1_A angle.r\
-|1_A 1_T 0_A angle.r ->  |1_A 0_T 0_A angle.r ->  |1_A 0_T 0_A angle.r\
-|1_A 1_T 1_A angle.r ->  |1_A 0_T 1_A angle.r->  |1_A 1_T 1_A angle.r
$

If the initial input state is $|+_A+_T+_A angle.r$, the output state will not change;
$ 
|0_A 0_T 0_A angle.r ->   |0_A 0_T 0_A angle.r->   |0_A 0_T 0_A angle.r\
|0_A 0_T 1_A angle.r -> - |0_A 1_T 1_A angle.r-> - |0_A 1_T 1_A angle.r\
|0_A 1_T 0_A angle.r ->   |0_A 1_T 0_A angle.r->   |0_A 1_T 0_A angle.r\
|0_A 1_T 1_A angle.r -> - |0_A 0_T 1_A angle.r-> - |0_A 0_T 1_A angle.r\
|1_A 0_T 0_A angle.r -> - |1_A 1_T 0_A angle.r-> - |1_A 1_T 0_A angle.r\
|1_A 0_T 1_A angle.r -> - |1_A 1_T 1_A angle.r-> - |1_A 0_T 1_A angle.r\
|1_A 1_T 0_A angle.r -> - |1_A 0_T 0_A angle.r-> - |1_A 0_T 0_A angle.r\
|1_A 1_T 1_A angle.r -> - |1_A 0_T 1_A angle.r-> - |1_A 1_T 1_A angle.r
$


Now, I changed the pulsesequence, in the second gate process, we achieve another phase accumulation process:
#figure(
  image("pulase.png", width: 60%),
)
If the input state is $|+_A-_T+_A angle.r$, the output state will be $|+_A-_T+_A angle.r$.
#figure(
  image("3minus.png", width: 60%),
)

If the input state is $|+_A+_T+_A angle.r$, the output state will be $|-_A+_T-_A angle.r$.
#figure(
  image("3plus.png", width: 60%),
)














Now, we concentrate on the dark state $|D angle.r = (|0 angle.r - |1 angle.r)/sqrt(2)$. 
The laser sequence and dynamic results are shown below:
#figure(
  image("laser_sequence.png", width: 50%),
)

#figure(
  image("minus.png", width: 50%),
)

#figure(
  image("plus.png", width: 50%),
)


//The whole process can be divided into two steps. Frome the figure shown above, we assume that an Z-error occurs in the middle data qubit "5". The syndrome information is mapped to the ancilla qubit denoted by red points through the multi-qubit gate. After that, we perform a measurement-free error correction process with the ancilla qubit acting as a control qubit in another multiqubit gate. The error qubit can be corrected by the ancella qubit with syndrome information.



  



The desired gate performance is :
// #figure(
//  table(
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

  rect((0.5 * dx, y1 + height + 0.2), (4.6 * dx, y3 - 0.2), fill: gray.transparentize(60%), stroke: none, radius: 0.1)
  content((2.5 * dx, y3 - 0.5), s[X-error check])

  rect((4.7 * dx, y1 + height + 0.2), (6.3 * dx, y3 - 0.2), fill: gray.transparentize(60%), stroke: none, radius: 0.1)
  content((5.3 * dx, y3 - 0.5), s[X-error correction]
  )

  // Hadamard gates
  //pulse(dx, y2, s[$h_1$], red)

  // EIT pulse
  pulse(0.8 * dx, y1, s[$h_D$], yellow)
  pulse(0.8 * dx, y2, s[$h_1$], red)
  pulse(1.3 * dx, y2, s[$b_1$], orange)
  pulse(1.8 * dx, y1, s[$c_D$], blue)
  pulse(2.3 * dx, y2, s[$b_1$], orange)
  pulse(4.3 * dx, y1, s[$h_D$], yellow)
  pulse(4.3 * dx, y2, s[$h_1$], red)

  pulse(2.8 * dx, y2, s[$d_1$], purple)
  pulse(3.3 * dx, y1, s[$e_D$], green)
  pulse(3.8 * dx, y2, s[$d_1$], purple)

  // //Hadamard gates
  // pulse(1.0 * dx, y2, s[$h_1$], red)
  // pulse(4.5 * dx, y2, s[$h_1$], red)

  // C2X pulse
  pulse(5.0 * dx, y2, s[$d_1$], purple)
  pulse(5.5 * dx, y1, s[$e_D$], green)
  pulse(6.0 * dx, y2, s[$d_1$], purple)

  // Reset A1
  pulse(6.7 * dx, y2, s[$R_1$], gray)

  set-origin((W, 0))
  line((0.0, y1 + height + 0.3), (0.0, y3 - 0.3), stroke: (dash: "dashed"))

  rect((0.1 * dx, y1 + height + 0.2), (4.4 * dx, y3 - 0.2), fill: gray.transparentize(60%), stroke: none, radius: 0.1)
  content((2.5 * dx, y3 - 0.5), s[Z-error check])

  rect((4.5 * dx, y1 + height + 0.2), (6.9 * dx, y3 - 0.2), fill: gray.transparentize(60%), stroke: none, radius: 0.1)
  content((5.7 * dx, y3 - 0.5), s[Z-error correction])

// Hadamard gates
  pulse(4.1 * dx, y1, s[$h_D$], yellow)

  // Hadamard gates
  pulse(0.4 * dx, y1, s[$h_D$], yellow)

  // Hadamard gates
  //pulse(0.4 * dx, y3, s[$h_2$], red.lighten(50%))

  // EIT pulse
  pulse(1.0 * dx, y3, s[$b_2$], orange.lighten(50%))
  pulse(1.5 * dx, y1, s[$c_D$], blue)
  pulse(2.0 * dx, y3, s[$b_2$], orange.lighten(50%))
  pulse(2.5 * dx, y3, s[$d_2$], purple.lighten(50%))

  pulse(3.0 * dx, y1, s[$e_D$], green)
  pulse(3.5 * dx, y3, s[$d_2$], purple.lighten(50%))

  // Hadamard gates
  //pulse(4.1 * dx, y3, s[$h_2$], red.lighten(50%))


  // C2Z pulse
  pulse(4.8 * dx, y1, s[$h_D$], yellow)
  pulse(5.3 * dx, y3, s[$d_2$], purple.lighten(50%))
  pulse(6.65 * dx, y1, s[$h_D$], yellow)
  pulse(5.7 * dx, y1, s[$e_D$], green)
  pulse(6.2 * dx, y3, s[$d_2$], purple.lighten(50%))

  // Reset A1
  pulse(7.2 * dx, y3, s[$R_2$], gray.lighten(50%))


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

// In the first round of parity check process, the minimum unit is shown below:
// #figure(
//   image("3species.png", width: 35%),
// )

// == Dual species architecture

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

