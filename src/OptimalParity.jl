module OptimalParity

using LinearAlgebra
using Yao
using RydbergPulse

include("PulseOpt.jl")

export create_multi_qubit_pauli_z, zgate

end