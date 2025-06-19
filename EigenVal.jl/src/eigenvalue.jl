
function state_to_decimal(state::String)
    level_to_num = Dict('1' => 0, 'r' => 1)
    if length(state) == 2
        return level_to_num[state[1]] * 2 + level_to_num[state[2]] + 1
    elseif length(state) == 3
        return level_to_num[state[1]] * 4 + level_to_num[state[2]] * 2 + level_to_num[state[3]] + 1
    elseif length(state) == 4
        return level_to_num[state[1]] * 8 + level_to_num[state[2]] * 4 + level_to_num[state[3]] * 2 + level_to_num[state[4]] + 1
    end
end

function compute_eigenvalues(A::AbstractMatrix)
    return eigen(A).values
end

function single_atom_matrix(Omega::Float64, Delta::Float64)
    H_0 = [0 Omega; Omega -Delta]
    return H_0
end

function two_atom_matrix(Omega::Float64, Delta::Float64, U_vdw::Float64)
    H_0 = [0 Omega; Omega -Delta]
    identity = [1 0; 0 1]
    H_1 = kron(H_0, identity) + kron(identity, H_0)
    dd = H_1[state_to_decimal("rr"), state_to_decimal("rr")]
    H_1[state_to_decimal("rr"), state_to_decimal("rr")] = dd + U_vdw

    return H_1
end

function three_atom_matrix(Omega::Float64, Delta::Float64, U_vdw::Float64)
    H_0 = [0 Omega; Omega -Delta]
    identity = [1 0; 0 1]
    H_1 = kron(H_0, identity, identity) + kron(identity, H_0, identity) + kron(identity, identity, H_0)
    dd1 = H_1[state_to_decimal("rr1"), state_to_decimal("rr1")]
    dd2 = H_1[state_to_decimal("r1r"), state_to_decimal("r1r")]
    dd3 = H_1[state_to_decimal("1rr"), state_to_decimal("1rr")]
    dd4 = H_1[state_to_decimal("rrr"), state_to_decimal("rrr")]
    H_1[state_to_decimal("rr1"), state_to_decimal("rr1")] = dd1 + U_vdw
    H_1[state_to_decimal("r1r"), state_to_decimal("r1r")] = dd2 + U_vdw
    H_1[state_to_decimal("1rr"), state_to_decimal("1rr")] = dd3 + U_vdw
    H_1[state_to_decimal("rrr"), state_to_decimal("rrr")] = dd4 + 3 * U_vdw
    return H_1
end

function four_atom_matrix(Omega::Float64, Delta::Float64, U_vdw::Float64)
    H_0 = [0 Omega; Omega -Delta]
    identity = [1 0; 0 1]
    H_1 = kron(H_0, identity, identity, identity) + 
          kron(identity, H_0, identity, identity) + 
          kron(identity, identity, H_0, identity) + 
          kron(identity, identity, identity, H_0)
    H_1[state_to_decimal("rr11"), state_to_decimal("rr11")] = U_vdw
    H_1[state_to_decimal("r1r1"), state_to_decimal("r1r1")] = U_vdw
    H_1[state_to_decimal("r11r"), state_to_decimal("r11r")] = U_vdw
    H_1[state_to_decimal("1rr1"), state_to_decimal("1rr1")] = U_vdw
    H_1[state_to_decimal("1r1r"), state_to_decimal("1r1r")] = U_vdw
    H_1[state_to_decimal("11rr"), state_to_decimal("11rr")] = U_vdw

    H_1[state_to_decimal("rrr1"), state_to_decimal("rrr1")] = 3 * U_vdw
    H_1[state_to_decimal("rr1r"), state_to_decimal("rr1r")] = 3 * U_vdw
    H_1[state_to_decimal("r1rr"), state_to_decimal("r1rr")] = 3 * U_vdw
    H_1[state_to_decimal("1rrr"), state_to_decimal("1rrr")] = 3 * U_vdw
    H_1[state_to_decimal("rrrr"), state_to_decimal("rrrr")] = 6 * U_vdw
    return H_1
end

function create_matrix_64(T::Float64, m::Int64)
    function HH(t::Float64)
        HA = zeros(64, 64)
        HA[m,m] = 1
        HB = ones(64, 64)/64
        return ((1 - t/T) * (Matrix(I, 64, 64) - HB) + (t/T) * (Matrix(I, 64, 64) - HA))
    end
    return HH
end


