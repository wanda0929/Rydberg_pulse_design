using Yao, Yao.EasyBuild
using LinearAlgebra
using YaoBlocks
using AdiabaticEvolution
using Test
using Plots


    @testset "Rabi_sin_pulse" begin
        Ω = 0.2 * 2π
        τ = 2*pi/Ω
        
        t_total = 2*pi/Ω
        times = 0:0.01:t_total
        
        # Calculate values for both functions
        Omega_0 = Rabi_sin(Ω, τ)
        Omega_1 = Rabi_square(Ω, τ)
        Omegavec = [Omega_0(t) for t in times]
        Omegavec_1 = [Omega_1(t) for t in times]
        
        # Create the plot
        p = Plots.plot(times, [real(Omegavec)/2/pi, real(Omegavec_1)/2/pi], 
            label=["Rabi Frequency Ω(t)" "Rabi Frequency Ω(t)"],
            title="Rabi Frequency",
            xlabel="Time",
            ylabel="Value",
            linewidth=2)
        display(p)
        @test p isa Plots.Plot
    end

    #@testset "twolevel_hamiltonian" begin
        Ω = 0.2 * 2π
        τ = 2*pi/Ω
        t_total = 2*pi/Ω
        times = 0:0.01:t_total  
        populations = Float64[]
        
        # Test basic Hamiltonian creation
        H = twolevelhami(Ω, τ, 0.0)
        @test H isa Function
        
        # Test evolution with different detunings
        for δ in -2*pi:0.5:2*pi    
            H = twolevelhami(Ω, τ, δ)
            reg = zero_state(1)
            pop = evolve_intwolevel(reg, H, t_total)
            push!(populations, pop[end])
        end
        
        p = Plots.plot(times, populations, 
            label="Population",
            title="Population",
            xlabel="Time",
            ylabel="Population",
            linewidth=2)
        display(p)
        @test p isa Plots.Plot
    #end

#H = twolevelhami(0.2, 2*pi/0.2, 0.0)