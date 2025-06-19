using LinearAlgebra
using ForwardDiff
using Optim
using QuadGK
using Plots

# 参数化路径 s(τ) 其中 τ ∈ [0,1]
#function s_path(t, params)
    
#    return 
#end

function Omegat(Ω0::Float64, Ω1::Float64, T::Float64)
    function O(t::Float64)
        return t/T * Ω0 + (1 - t/T) * Ω1
    end
    return O
end

function Detuningt(Δ0::Float64, Δ1::Float64, T::Float64)
    function D(t::Float64)
        return t/T * Δ0 + (1 - t/T) * Δ1
    end
    return D
end

# 哈密顿量函数
function QAB_hamiltonian(t::Float64, s::Float64, Ω0::Float64, Ω1::Float64, Δ0::Float64, Δ1::Float64)
    H = -0.5 * (Omegat(Ω0, Ω1, T) * X + Detuningt(Δ0, Δ1, T) * Z)
    return H
end

# 计算哈密顿量对 s 的导数
function dH_ds(Ω0::Float64, Ω1::Float64, Δ0::Float64, Δ1::Float64, T::Float64)
    dΩ_ds = Ω0 - Ω1
    dΔ_ds = Δ0 - Δ1
    return -0.5 * (dΩ_ds * X + dΔ_ds * Z)
end

# 计算瞬时本征值和本征态
function instantaneous_eigensystem(Hamiltonian, )
    H_s = H(s)
    F = eigen(H_s)
    idx = sortperm(real.(F.values))
    return F.values[idx], F.vectors[:, idx]
end

# 计算能隙
function energy_gap(s)
    eigvals, _ = instantaneous_eigensystem(s)
    return abs(eigvals[1] - eigvals[2])
end

# 计算矩阵元 |<0|dH/ds|1>|
function matrix_element(s)
    _, eigvecs = instantaneous_eigensystem(s)
    dH = dH_ds(s)
    return abs(eigvecs[:, 1]' * dH * eigvecs[:, 2])
end

# 计算 ds/dt 的绝热条件
function ds_dt(s)
    ΔE = energy_gap(s)
    mat_elem = matrix_element(s)
    return (ΔE^2) / (ħ * mat_elem)
end



# 路径导数 ds/dτ
function ds_dτ(τ, params)
    # 使用自动微分计算 ds/dτ
    return ForwardDiff.derivative(τ -> s_path(τ, params), τ)
end

# 计算总演化时间 T
function total_time(params)
    # 被积函数: dt = [ħ |<0|dH/ds|1>| / ΔE^2] * ds
    # 但使用 τ 参数化: dt = [ħ |<0|dH/ds|1>| / ΔE^2] * (ds/dτ) dτ
    function integrand(τ)
        s = s_path(τ, params)
        ds_dτ_val = ds_dτ(τ, params)
        
        # 确保路径单调
        if ds_dτ_val < 0
            return Inf  # 惩罚非单调路径
        end
        
        ΔE = energy_gap(s)
        mat_elem = matrix_element(s)
        
        # 避免除以零
        if ΔE < 1e-10
            return Inf
        end
        
        return (ħ * mat_elem / ΔE^2) * ds_dτ_val
    end
    
    # 计算积分
    T, err = quadgk(integrand, 0, 1, rtol=1e-6)
    
    # 添加路径约束惩罚项
    penalty = 0.0
    for τ in range(0, 1, length=20)
        s_val = s_path(τ, params)
        if s_val < 0 || s_val > 1
            penalty += 100 * (abs(s_val - clamp(s_val, 0, 1))^2)
        end
    end
    
    return T + penalty
end

# 优化路径参数
function optimize_path(;degree=3, max_iter=100)
    # 初始参数 (小随机值)
    initial_params = 0.1 * randn(degree)
    
    # 定义优化目标
    objective(p) = total_time(p)
    
    # 使用 L-BFGS 优化器
    result = optimize(objective, initial_params, LBFGS(),
                      Optim.Options(iterations=max_iter, show_trace=true))
    
    return result
end

# 计算演化路径
function compute_evolution_path(params; npoints=100)
    τ_points = range(0, 1, length=npoints)
    s_points = [s_path(τ, params) for τ in τ_points]
    t_points = zeros(npoints)
    
    # 计算时间点
    for i in 2:npoints
        τ_prev = τ_points[i-1]
        τ_curr = τ_points[i]
        t_points[i] = t_points[i-1] + quadgk(τ -> 
            (ħ * matrix_element(s_path(τ, params)) / energy_gap(s_path(τ, params))^2) * 
            ds_dτ(τ, params), τ_prev, τ_curr, rtol=1e-6)[1]
    end
    
    return t_points, s_points
end

# 计算保真度
function compute_fidelity(params; nsteps=100)
    τ_points = range(0, 1, length=nsteps)
    ψ = [1.0, 0.0]  # 初始态 |↓>
    
    # 绝热参考态
    _, eigvecs_initial = instantaneous_eigensystem(0.0)
    ψ_adiabatic = eigvecs_initial[:, 1]
    
    fidelities = zeros(nsteps)
    fidelities[1] = abs(dot(ψ, ψ_adiabatic))^2
    
    # 简单欧拉积分
    for i in 2:nsteps
        τ_prev = τ_points[i-1]
        τ_curr = τ_points[i]
        s_prev = s_path(τ_prev, params)
        s_curr = s_path(τ_curr, params)
        
        # 计算时间步长
        dt = quadgk(τ -> 
            (ħ * matrix_element(s_path(τ, params)) / energy_gap(s_path(τ, params))^2) * 
            ds_dτ(τ, params), τ_prev, τ_curr, rtol=1e-6)[1]
        
        # 计算哈密顿量
        H_prev = H(s_prev)
        H_curr = H(s_curr)
        
        # 近似演化算符
        U = exp(-im * (H_prev + H_curr)/2 * dt / ħ)
        ψ = U * ψ
        
        # 归一化
        ψ /= norm(ψ)
        
        # 计算绝热参考态
        _, eigvecs = instantaneous_eigensystem(s_curr)
        ψ_adiabatic = eigvecs[:, 1]
        
        # 计算保真度
        fidelities[i] = abs(dot(ψ, ψ_adiabatic))^2
    end
    
    return fidelities
end

# 主函数
function main()
    println("开始优化绝热路径...")
    result = optimize_path(degree=4, max_iter=50)
    
    if Optim.converged(result)
        optimized_params = Optim.minimizer(result)
        T_min = Optim.minimum(result)
        println("\n优化成功!")
        println("最小演化时间: ", T_min)
        println("优化参数: ", optimized_params)
        
        # 计算优化路径
        t_points, s_points = compute_evolution_path(optimized_params)
        
        # 计算未优化路径 (线性路径)
        t_linear, s_linear = compute_evolution_path(zeros(4))
        
        # 绘制路径比较
        p1 = plot(t_linear, s_linear, label="线性路径", lw=2, xlabel="时间", ylabel="s(t)", title="路径比较")
        plot!(p1, t_points, s_points, label="优化路径", lw=2)
        
        # 计算保真度
        fidelities_opt = compute_fidelity(optimized_params)
        fidelities_lin = compute_fidelity(zeros(4))
        
        p2 = plot(range(0, 1, length=length(fidelities_lin)), fidelities_lin, 
                 label="线性路径", lw=2, xlabel="τ", ylabel="保真度", title="保真度比较")
        plot!(p2, range(0, 1, length=length(fidelities_opt)), fidelities_opt, 
              label="优化路径", lw=2)
        
        # 绘制能隙和矩阵元
        s_vals = range(0, 1, length=100)
        gaps = [energy_gap(s) for s in s_vals]
        mat_elems = [matrix_element(s) for s in s_vals]
        
        p3 = plot(s_vals, gaps, label="能隙 ΔE(s)", lw=2, xlabel="s", ylabel="值", title="能隙")
        p4 = plot(s_vals, mat_elems, label="|<0|dH/ds|1>|", lw=2, xlabel="s", ylabel="值", title="矩阵元")
        
        # 显示所有图形
        plot(p1, p2, p3, p4, layout=(2,2), size=(1000,800))
        
        # 保存结果
        savefig("adiabatic_optimization.png")
    else
        println("优化未收敛，请尝试增加迭代次数或调整参数")
    end
end

# 运行主函数
main()
