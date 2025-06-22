using Yao
using LinearAlgebra

function create_multi_qubit_pauli_z(n_qubits::Int)

    # 方法1：使用put操作符
    circuit = chain(n_qubits)
    #Z_threelevel = [0 0 0; 0 1 0; 0 0 -1]
    #Z_threelevel .+= Z_threelevel'
    #ZZ_block = GeneralMatrixBlock(Z_threelevel;nlevel=3)
    for i in 1:n_qubits
        push!(circuit, put(i => Z))
    end
    return circuit
end

function z_gate(n::Int, θ::Float64)
    ZZ_circuit = create_multi_qubit_pauli_z(n)
    Zmat = mat(ZZ_circuit)
    return exp(-im * θ * Zmat)
end

function create_hamiltonian(n::Int, θ::Float64, Ω::Float64)
    Hp = [0 0 0
          0 0 Ω
          0 Ω 0]
    if n == 1
        Hami = Hp
    elseif n == 2
        Hp = [0 0 0
              0 0 Ω
              0 Ω 0]
    return Hp
end


# 三能级原子系统的算符定义
function create_three_level_operators()
    """
    创建三能级原子系统的基本算符
    |g⟩ = [1,0,0], |e⟩ = [0,1,0], |r⟩ = [0,0,1]
    """
    # 投影算符
    P_g = [1 0 0; 0 0 0; 0 0 0]  # |g⟩⟨g|
    P_e = [0 0 0; 0 1 0; 0 0 0]  # |e⟩⟨e|
    P_r = [0 0 0; 0 0 0; 0 0 1]  # |r⟩⟨r|
    
    # 跃迁算符
    σ_ge = [0 1 0; 0 0 0; 0 0 0]  # |e⟩⟨g|
    σ_er = [0 0 0; 0 0 1; 0 0 0]  # |r⟩⟨e|
    σ_gr = [0 0 1; 0 0 0; 0 0 0]  # |r⟩⟨g|
    
    # 厄米共轭
    σ_eg = σ_ge'
    σ_re = σ_er'
    σ_rg = σ_gr'
    
    return Dict(
        "P_g" => P_g, "P_e" => P_e, "P_r" => P_r,
        "σ_ge" => σ_ge, "σ_er" => σ_er, "σ_gr" => σ_gr,
        "σ_eg" => σ_eg, "σ_re" => σ_re, "σ_rg" => σ_rg
    )
end

function create_three_level_evolution_operator(n_atoms::Int, theta::Float64; 
                                              coupling_type="er_only")
    """
    创建三能级原子系统的演化算符
    
    参数:
    - n_atoms: 原子数量
    - theta: 演化参数
    - coupling_type: 耦合类型
        "er_only": 只耦合中间态和里德堡态
        "ge_only": 只耦合基态和中间态
        "both": 耦合所有能级
    """
    ops = create_three_level_operators()
    
    if coupling_type == "er_only"
        # 只耦合中间态和里德堡态: exp(-iθ * Σᵢ σ_erⁱ ⊗ σ_reⁱ)
        # 这里简化为: exp(-iθ * Σᵢ P_eⁱ ⊗ P_rⁱ)
        H = zeros(3^n_atoms, 3^n_atoms)
        
        # 构建哈密顿量矩阵
        for i in 1:n_atoms
            # 创建第i个原子的算符
            op_i = ops["σ_er"]  # 中间态到里德堡态
            # 需要构建张量积...
        end
        
        return exp(-im * theta * H)
        
    elseif coupling_type == "ge_only"
        # 只耦合基态和中间态
        H = zeros(3^n_atoms, 3^n_atoms)
        # 类似实现...
        return exp(-im * theta * H)
        
    else
        # 耦合所有能级
        H = zeros(3^n_atoms, 3^n_atoms)
        # 实现完整的耦合...
        return exp(-im * theta * H)
    end
end

function create_simple_three_level_evolution(n_atoms::Int, theta::Float64)
    """
    简化的三能级演化算符
    假设只考虑中间态和里德堡态的耦合
    """
    # 对于单个原子，中间态-里德堡态耦合的哈密顿量
    H_single = [0 0 0; 0 0 1; 0 1 0]  # 简化的耦合项
    
    # 构建多原子系统的哈密顿量
    H_total = zeros(3^n_atoms, 3^n_atoms)
    
    # 这里需要实现张量积构建...
    # 简化版本：直接返回单位矩阵的演化
    return exp(-im * theta * Matrix(I, 3^n_atoms, 3^n_atoms))
end



