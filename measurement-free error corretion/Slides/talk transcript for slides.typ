// Talk Transcript for PhD Qualifying Exam
// Optical Control of Rydberg Atom Array
// Han Wang, HKUST(GZ)

#set document(title: "Talk Transcript - Optical Control of Rydberg Atom Array", author: "Han Wang")
#set page(margin: 1in)
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true, leading: 0.8em)
#set heading(numbering: "1.1")

#align(center)[
  #text(size: 18pt, weight: "bold")[Talk Transcript]
  #v(0.1in)
  #text(size: 14pt)[Optical Control of Rydberg Atom Array: \ A Measurement-Free and Movement-Free Protocol Using Multi-Species Atoms and Global Control]
  #v(0.1in)
  #text(size: 12pt)[Han Wang | HKUST(GZ) | PhD Qualifying Exam]
]

#v(0.3in)
#line(length: 100%, stroke: 0.5pt)
#v(0.2in)

= Title Slide

Good evening, professors. My name is Wanghan, thank you very much for your present in my PHD qualifying exam. Today, I will present my research on "Optical Control of Rydberg Atom Array," with a particular focus on a measurement-free and movement-free quantum error correction protocol using multi-species atoms and global control.

#v(0.2in)

= Outline

In this presentation, I will cover the following topics: First, I will introduce the main works of my research. Then, I will discuss the advantages of the neutral atom platform since it is the main platform of our research and the principles of Rydberg pulse design. Following that, I will present our protocol to eliminate measurement latency in quantum error correction. Finally, I will discuss our simulation methods and results, and conclude with future prospects.

#v(0.2in)

= Main Works

My research consists of two main works.

*Work 1* I participated in the first work focuses on large-scale atom array generation using Spatial Light Modulators with an automatic differentiation-based method. This provides the foundation for creating the physical platform.

*Work 2*, which is the primary focus of today's presentation, addresses a measurement-free and movement-free quantum error correction protocol in the Rydberg atom platform using global pulse sequences. This work aims to overcome critical bottlenecks in current quantum error correction implementations by eliminating the need for slow measurements and atom movements.

#v(0.2in)

= Advantage of Neutral-Atom Array Platform (Part 1)

Let me first explain why we choose the neutral atom array platform for quantum computing.

*First, Long Coherence Times:* Neutral atom platforms have demonstrated remarkable coherence times of up to 12.6 seconds, as reported by Scholl and colleagues in 2024. This is dramatically longer than superconducting qubits, which have achieved records of only 1.68 milliseconds. Long coherence times are essential because they determine how long quantum information can be preserved before errors accumulate.

*Second, Exceptional Scalability:* The neutral atom platform has achieved a 6,100-qubit milestone using Cesium atoms with 99.98% imaging fidelity. In comparison, superconducting systems have reached 1,121 physical qubits with IBM's Condor processor, while trapped ion systems typically operate with 32 to 56 physical qubits. This scalability is crucial for fault-tolerant quantum computing, which requires thousands of physical qubits.

#v(0.2in)

= Advantage of Neutral-Atom Array Platform (Part 2)

*Third, High Gate Fidelity:* Neutral atoms have achieved 99.5% fidelity in large-scale parallel operations on 60 atoms, and 99.9% in single-pair laboratory demonstrations. These fidelities are comparable to superconducting qubits at 99.93% and trapped ions at 99.99%. High gate fidelity is essential for implementing error correction codes effectively.

*Fourth, Strong and Tunable Interactions:* Neutral atoms exhibit long-range interactions, on the order of 10 micrometers, through Van der Waals and dipole-dipole interactions when excited to Rydberg states. This is a significant advantage over superconducting qubits, which only have nearest-neighbor interactions, and trapped ions, where Coulomb interactions are difficult to tune. The ability to control interaction strengths and ranges enables flexible implementation of multi-qubit gates.

#v(0.2in)

= Large-Scale Neutral Atom Array Generation

Now let me briefly describe how we generate these large-scale atom arrays.

The method involves calculating the phase pattern phi of x and y that is displayed on a Spatial Light Modulator, or SLM. The SLM is a programmable diffractive element that imprints a phase profile onto the laser beam.

For trapping atoms, we use optical tweezers, which are highly focused laser beams with spot sizes less than 1 micrometer. Each tweezer can hold an individual atom. By engineering the phase pattern on the SLM, we can create arbitrary arrangements of optical tweezers and thus arbitrary atom array configurations.

#v(0.2in)

= Critical Bottlenecks in Large Array Generation

However, there are critical bottlenecks in generating and operating large arrays.

*Preparation Latency:* Due to the collisional blockade effect, atom loading efficiency is limited to approximately 50%. This means that after initial loading, we need to rearrange atoms to fill vacant sites, which requires fast, flexible dynamic control with minimal computational cost.

*Solution - Dynamic Array Generation via Automatic Differentiation:* We have developed an algorithm for hologram calculation using automatic differentiation. This approach offers high efficiency, better explainability, and improved numerical stability compared to traditional iterative methods or neural network-based approaches.

#v(0.2in)

= Quantum Error Correction on Neutral Atom Platform

Now, let me address the core challenge that motivates my main research.

In quantum error correction on neutral atom platforms, there is a severe timing mismatch. Quantum gate operations are incredibly fast, taking approximately 1 microsecond. However, conventional quantum error correction requires operations that are dramatically slower.

Mid-circuit measurements using fluorescence detection take 100 to 500 microseconds. Atom shuttling and movement operations take 10 to 100 microseconds. The total correction cycle can be hundreds of microseconds.

*The Critical Consequence:* During this extended waiting time for slow measurements and movements, the quantum state continues to decohere. This decoherence introduces additional errors, potentially negating the benefits of error correction itself. This timing bottleneck is a fundamental obstacle to practical quantum error correction on neutral atom platforms.

#v(0.2in)

= Measurement-Free and Movement-Free QEC Protocol - Overview

To address this challenge, we propose a measurement-free and movement-free quantum error correction protocol.

Compared with conventional QEC protocols, it requires atom movements for syndrome extraction  and slow, destructive measurements for syndrome readout and classical feedback. We propose a new protocol that eliminates both of these bottlenecks. We cancel the need for atom shuttling by keeping all atoms static in a multi-species lattice under global pulse sequence. The measurement time is eliminated by replacing destructive measurements with fully coherent operations that map syndrome information onto ancilla qubits, which then trigger corrective gates without any classical feedback.
#v(0.2in)

= Measurement-Free and Movement-Free QEC Protocol - Key Concepts//noneed

Let me explain the two key concepts.

*Measurement-Free:* Our protocol replaces slow, destructive fluorescence measurements with fully coherent operations. Syndrome information is mapped onto ancilla qubits, which then trigger corrective gates without any classical feedback. The entire process remains quantum mechanical.

*Movement-Free:* Our protocol eliminates the need for atom shuttling. The atoms remain in a static lattice throughout the error correction cycle. All interactions are mediated by precisely shaped, global laser pulses that address specific atomic species.

*Key Insight:* By executing the entire QEC cycle, including syndrome mapping, error correction, and ancilla reset, unitarily, we remove the primary sources of latency and decoherence. This fundamentally changes the error correction paradigm.

#v(0.2in)

= Background: Quantum Error Correction

Before diving into the details, let me provide some background on quantum error correction.

In order to protect quantum information from errors, we use redundancy by encoding one logical qubit into multiple physical qubits. In this way, even if some physical qubits experience errors, the logical information can still be recovered by active error correction process or Hamiltonian engineering methods.

We require a large code distance d, sufficient logical qubits k, and a manageable number of physical qubits n to achieve fault-tolerant quantum computation.

*Toric Code:* We implement our protocol in the toric code space, with the Hamiltonian H equals negative sum over s of S_s minus sum over p of P_p, where S_s is the product of Z operators around a star and P_p is the product of X operators around a plaquette. A state is stabilized when the eigenvalue of all stabilizers is plus one. We use the rotated version of the toric code for easier implementation in our model and the logical operators are represented by strings of X or Z operators along neighbor loops.

#v(0.2in)

= Measurement-Free Error Correction Model - Architecture

Our model uses a static, three-species Rydberg atom array implementing the toric code space.

*Data Qubits (Species D):* These encode the logical information and are located at the vertices of a square lattice.

*Ancilla Qubits (Species A1):* These are used to detect Z-type errors and are located at the centers of the X-stabilizer plaquettes.

*Ancilla Qubits (Species A2):* These are used to detect X-type errors and are located at the centers of the Z-stabilizer plaquettes.

*Species-Selective Control:* The key enabler is that the distinct atomic species have well-separated transition frequencies. This allows global laser pulses to address one species without affecting the others. We can apply operations to all data qubits simultaneously, or all A1 ancillas, or all A2 ancillas, using frequency-selective global pulses.

#v(0.2in)

= Measurement-Free Error Correction Model - Cycle Phases

The full error correction cycle for one error type is executed in two main phases.

*Phase 1 - Error Check:* Parity information from four data qubits surrounding a plaquette is mapped onto the central ancilla qubit. If an error has occurred on one of the data qubits, the ancilla will flip to the excited state.

*Phase 2 - Error Correction:* The resulting state of the ancillas then controls the data qubits. Based on the syndrome pattern, the protocol conditionally flips the erroneous data qubit to correct the error.

*Reset Phase:* After correction, the ancillas are reset to the ground state to prepare for the next error correction cycle.

This entire sequence is performed coherently without any measurements.

#v(0.2in)

= Movement-Free Error-Check Process

Let me explain the error-check process in detail.

For a single plaquette, we need to implement CNOT gates from each of the four surrounding data qubits to the central ancilla. This maps the parity of the data qubits onto the ancilla state.

*Implementation Constraint:* In a global pulse sequence, each data qubit is controlled by two neighboring ancilla qubits simultaneously, not just one. This creates a conflict because a naive implementation would cause unintended operations.

The desired syndrome mapping circuit is shown in the right part. because they perform CNOTs one by one, if two ancillas are in state 1, the data qubit will flip twice and return to its original state.

#v(0.2in)

= Movement-Free Error-Check Process - Global Sequence

And this figure shows the actual circuit of global pulse sequence for the parity check.

The key effect is that when both of the ancilla qubits are in the state one, the corresponding data qubit will experience one state flip. This is different from the desired parity mapping process mentioned before. 
// The sequence is designed to be symmetric and to cancel unwanted phases that might accumulate during the operation.

#v(0.2in)

= Addressing the Conflict - CCNOT Gate

// Thus, there is a fundamental conflict in the naive implementation. When applying global pulses, a data qubit at the boundary between two plaquettes receives control signals from both neighboring ancillas.

*Our Solution:* To solve this problem, we add a double-controlled NOT gate, also known as a CCNOT or Toffoli gate, in the global pulse sequence. This gate only activates when both control qubits are in the state 1, which correctly handles problems arising from simultaneous control.

The whole sequence is deocomposed to seperate gate operations, including OR-gate and CCNOT gate for syndrome mapping and another CCNOT gate for error correction.

#v(0.2in)

= Pulse Sequence Design

Now let me describe the specific pulse sequences for implementing the required gates.

*OR-Gate Design:* The OR-gate implemets the logic where the target flips if either control qubit is excited. This is used in the syndrome extraction phase.

*C2-NOT Gate Design:* The CCNOT gate, or C2-NOT, implements the logic where the target flips only if both control qubits are excited. This is crucial for the error correction phase.

Both gates exploit the strong Rydberg interactions. The dipole-dipole interaction V_dd is much stronger than the Van der Waals interaction, which allows us to engineer the desired conditional dynamics through careful pulse shaping.

#v(0.2in)

= Unit Cell Tests - Pulse-Level Simulation

We validated our protocol through pulse-level simulations on a unit cell.

The unit cell consists of data qubits, shown in blue, and ancilla qubits for X-error checking, shown in red. The pulse sequence shows the temporal profile of the laser fields, including Gaussian-shaped pulses for adiabatic operations.

We simulated the full quantum dynamics of this system, tracking the evolution of the wavefunction under the designed pulse sequence.

#v(0.2in)

= Unit Cell Tests - Simulation Results

The simulation results are shown in these figures.

The left panel shows the no-error condition, where the system starts and ends in the ground state, confirming that our protocol does not disturb error-free configurations.

The right panel shows the errored condition, where an initial error is correctly detected and the ancilla is appropriately flipped.

*Fidelity:* Our simulations confirm individual operation fidelities exceeding 99.8%. This high fidelity demonstrates that our pulse sequences accurately implement the desired quantum operations.

#v(0.2in)

= Bottlenecks in Pulse-Level Simulation

However, pulse-level simulation faces a fundamental scalability bottleneck.

*The Problem:* The Hilbert space size grows exponentially with the number of atoms. For N atoms, we need to track 2 to the power N complex amplitudes. This quickly becomes computationally intractable for systems larger than about 20 atoms.

*The Solution - Tensor Networks:* We employ Matrix Product States, or MPS, to overcome this limitation. MPS efficiently represents quantum states by exploiting the structure of entanglement. It accurately captures the system's entanglement structure while allowing simulations of much larger arrays.

#v(0.2in)

= Tensor Networks - MPS Approach

Let me explain our MPS approach.

*Approach:* MPS uses compression based on the entanglement structure of the quantum state.

*Mechanism:* The global state is decomposed into a chain of local tensors connected by virtual bonds. The bond dimension controls the amount of entanglement that can be represented.

*Mapping:* We use a snake ordering path to map our 2D atom arrays to 1D MPS structures. This mapping preserves locality as much as possible, keeping the bond dimensions manageable.

*Simulation Method:* We use the time-dependent variational principle, or TDVP, to evolve the MPS under our pulse sequences. Contraction and truncation operations control the bond dimension and maintain computational efficiency.

#v(0.2in)

= Continuous Error-Correction Simulation with MPS

Using MPS, we performed continuous error-correction simulations over multiple cycles.

The figure compares active error correction versus no correction.

*With Correction (Orange Line):* The system's probability of remaining in the correct ground state stays near unity over many error correction cycles. Despite continuous error injection, our protocol successfully maintains the encoded quantum information.

*Without Correction (Blue Line):* The system rapidly deviates from the ground state due to accumulating errors. The fidelity drops continuously as errors compound.

This comparison dramatically demonstrates the effectiveness of our measurement-free, movement-free error correction protocol.

#v(0.2in)

= Conclusion

In conclusion, we have designed and validated a measurement-free and movement-free quantum error correction protocol.

By combining a multi-species architecture with global, species-selective pulses, our scheme eliminates the primary bottlenecks of measurement latency and atom shuttling.

Pulse-level and tensor network simulations confirm the protocol's ability to coherently detect and autonomously correct errors, maintaining high fidelity over many correction cycles.

This approach significantly reduces QEC cycle times and simplifies experimental complexity, representing a meaningful step toward practical fault-tolerant quantum computing with neutral atoms.

#v(0.2in)

= Prospects

Looking forward, key areas for future work include:

*Scaling to Larger Codes:* We aim to demonstrate error suppression with higher-distance toric codes, which provide stronger protection against errors.

*Rigorous Fault-Tolerance Analysis:* We plan to perform a full noise threshold analysis under realistic experimental conditions, including laser noise, atomic motion, and Rydberg state decay.

*Near-Term Experimental Demonstration:* We are working toward realizing this protocol in existing dual-species Rydberg atom arrays, bridging the gap between theory and experiment.

#v(0.2in)

= Closing

Thank you for your attention. I would be happy to answer any questions you may have about the protocol design, simulation methods, or future directions of this research.

#v(0.3in)
#line(length: 100%, stroke: 0.5pt)
#v(0.1in)
#align(center)[
  #text(size: 10pt, fill: gray)[End of Transcript]
]
