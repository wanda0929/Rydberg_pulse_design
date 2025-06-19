module OptimalParity

# Write your package code here.
using LinearAlgebra
using Yao
using RydbergPulse


include("pulseopt.jl")

export create_multi_qubit_pauli_z, zgate
end
