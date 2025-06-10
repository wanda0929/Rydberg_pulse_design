# RydbergPulseDesign.jl

A Julia package for designing and optimizing control pulses for Rydberg atom systems.

## Installation

To install the package, use the Julia package manager:

```julia
using Pkg
Pkg.add(url="https://github.com/yourusername/RydbergPulseDesign.jl")
```

## Usage

Here's a basic example of using the package:

```julia
using RydbergPulseDesign
using QuantumOptics

# Create a Hamiltonian
H = create_rydberg_hamiltonian(1.0, 0.0, 2)

# Create initial state
b = SpinBasis(1//2)
ψ₀ = spinup(b)

# Simulate dynamics
tout, ψt = simulate_dynamics(H, ψ₀, 0.0:0.1:10.0)
```

For more examples, see the `examples/` directory.

## Features

- Creation of Rydberg Hamiltonians
- Quantum dynamics simulation
- Pulse optimization (coming soon)

## Documentation

Documentation is available at [documentation link].

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details. 