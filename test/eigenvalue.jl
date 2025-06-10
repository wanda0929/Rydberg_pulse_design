using Test
using Eigenval
using LinearAlgebra
using Plots

@test state_to_decimal("11") == 1
@test state_to_decimal("1r") == 2
@test state_to_decimal("r1") == 3
@test state_to_decimal("rr") == 4
@test state_to_decimal("111") == 1
@test state_to_decimal("11r") == 2
@test state_to_decimal("1r1") == 3
@test state_to_decimal("1rr") == 4
@test state_to_decimal("1111") == 1
@test state_to_decimal("111r") == 2
@test state_to_decimal("11r1") == 3

@testset "single_atom_matrix" begin
    @test single_atom_matrix(1.0, 2.0) == [0 1; 1 -2]
end

@testset "two_atom_matrix" begin
    @test two_atom_matrix(1.0, 2.0, 3.0) == [0 1 1 0; 1 -2 0 1; 1 0 -2 1; 0 1 1 -1]
end

@testset "three_atom_matrix" begin
    @test three_atom_matrix(1.0, 2.0, 3.0) == [0  1  1  0  1  0   0   0;   
     1  -2 0  1  0  1   0   0;
     1  0  -2 1  0  0   1   0;
     0  1  1  -1 0  0   0   1;
     1  0  0   0 -2 1   1   0;
     0  1  0   0 1  -1  0   1;
     0  0  1   0 1  0   -1  1;
     0  0  0   1 0  1   1   3]
end

@testset "four_atom_matrix" begin
    @test four_atom_matrix(1.0, 2.0, 3.0) == 
    [0  1  1  0  1  0   0   0   1  0   0   0   0  1  0   0;
     1  -2 0  1  0  -2  0   0   0  -2  0   0   0  0  -2  0;
     1  0  -2 1  0  0   -2  0   0  0   -2  0   0  0  0   -2;
     0  1  1  -1 0  0   0   -1  0  0   0   -1  0  0  0   -1]
end


@testset "create_matrix_64" begin
    T = 1.0
    m = 1
    matrix_function = create_matrix_64(T, m)

    for t in 0:0.1:1
        Hami = matrix_function(t)
    end
    A = zeros(64, 64)
    A[1,1] = 1
    B = ones(64, 64)/64

    @test matrix_function(1.0) == Matrix(I, 64, 64) - A
    matrix_function(0.0)
    @test matrix_function(0.0) == Matrix(I, 64, 64) - B
end

@testset "create_matrix_64" begin
    T = 1.0
    m = 1
    matrix_function = create_matrix_64(T, m)
    
    # 先创建时间点数组
    time_points = collect(0:0.1:1)  # 使用collect转换为数组
    eigenvalues_array = [Float64[] for _ in 1:64]

    # 计算本征值
    for t in time_points
        Hami = matrix_function(t)
        eigenvalues = eigen(Hami).values
        
        for i in 1:64
            push!(eigenvalues_array[i], eigenvalues[i])
        end
    end
    
    # 创建新的图
    p = plot(
        title = "Eigenvalue Evolution",
        xlabel = "t/T",
        ylabel = "Eigenvalue",
        legend = false  # 64条线的图例会太乱，建议关闭
    )

    # 绘制所有本征值曲线
    for i in 1:64
        plot!(p, time_points, eigenvalues_array[i])
    end

    # 显示图像
    display(p)
end