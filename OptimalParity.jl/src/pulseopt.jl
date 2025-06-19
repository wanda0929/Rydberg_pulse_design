

function zgate(n::Int, θ::Float64)
    ZZ = create_multi_qubit_pauli_z(n)
    return exp(im * θ * (-1)^n) * exp(-im * θ * ZZ)
end

# 示例：创建多个比特的Pauli-Z算符的张量积
function create_multi_qubit_pauli_z(n_qubits::Int)
    """
    创建n_qubits个比特的Pauli-Z算符的张量积
    例如：sigma_1^z ⊗ sigma_2^z ⊗ sigma_3^z ⊗ sigma_4^z
    """
    # 方法1：使用put操作符
    circuit = chain(n_qubits)
    for i in 1:n_qubits
        push!(circuit, put(i => Z))
    end
    return circuit
end

function hamiltonian(n::Int, θ::Float64, Omega)
    Hp = [Δ/2 Ω/2 0
          conj(Ω)/2 -Δ/2 0
          0 0 0]
end