using Random
using RydbergPulse
using Yao
using OptimalParity
using Test

@testset "PulseOpt" begin
    nqubits = 2
    dim = 2^nqubits
    
    init_state_g = zeros(Complex{Float64}, dim)
    init_state_g[1] = 1.0
    init_state_e = zeros(Complex{Float64}, dim)
    init_state_e[4] = 1.0
    int_state_ge = zeros(Complex{Float64}, dim)
    int_state_ge[2] = 1.0

    @test init_state_g == [1.0, 0.0, 0.0, 0.0]
    @test init_state_e == [0.0, 0.0, 0.0, 1.0]
    @test int_state_ge == [0.0, 1.0, 0.0, 0.0]
    ZZ_circuit = create_multi_qubit_pauli_z(nqubits)
    final_g = mat(ZZ_circuit) * init_state_g
    final_e = mat(ZZ_circuit) * init_state_e
    final_ge = mat(ZZ_circuit) * int_state_ge
    @test norm(final_g - init_state_g) < 1e-6
    @test norm(final_e - init_state_e) < 1e-6
    @test norm(final_ge - int_state_ge) == 2.0

end

@testset "zgate" begin
    nqubits = 2
    θ = pi/4
    zoperator = z_gate(nqubits, θ)
    init_state_g = zeros(Complex{Float64}, 2^nqubits)
    init_state_g[1] = 1.0
    final_g = zoperator * init_state_g
    @test norm(final_g - init_state_g) == norm(exp(-im * θ) - 1.0)
end

