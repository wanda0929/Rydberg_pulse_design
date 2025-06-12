using AdiabaticEvolution
using Test

@testset "AdiabaticEvolution.jl" begin
    include("two_level_transmission.jl")
    include("ARP_pulse.jl")
    include("ARP_pulse_2.jl")
end 