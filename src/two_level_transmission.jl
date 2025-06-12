using Yao, Yao.EasyBuild

function Rabi_sin(Ω::Float64, τ::Float64)
    function S(t::Float64)
        return real(Ω * (sin(π * t / τ))^2)
    end
    return S
end

function Rabi_square(Ω::Float64, τ::Float64)
    function S(t::Float64)
        if 0 <= t <= τ/2
            return Ω
        elseif τ/2 < t <= τ
            return 0
        else
            return 0.0
        end
    end
    return S
end

function twolevelhami(Ω::Float64, τ::Float64, δ::Float64)
    H(t) = 0.5 * (Rabi_sin(Ω, τ)(t) * put(1,1=>X) + δ * put(1,1=>Z))
    return H
end

function twolevelhami_square(Ω::Float64, τ::Float64, δ::Float64)
    H(t) = 0.5 * (Rabi_square(Ω, τ)(t) * put(1,1=>X) + δ * put(1,1=>Z))
    return H
end


function evolve_intwolevel(reg, hamiltonian, t_total::Float64, Nt = 10000)
    dt = t_total / Nt
    populations = Float64[]
    zz = (I2-Z)/2
    for it = 1:Nt
        t = (it-0.5) * dt
        apply!(reg, time_evolve(hamiltonian(t), dt))
        push!(populations, expect(zz, reg))
    end
    return populations
end

