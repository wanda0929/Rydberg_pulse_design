"""
    eigenval

A Julia package for eigenvalue computations and analysis.
"""
module eigenval

using LinearAlgebra

include("eig_function.jl")

export compute_eigenvalues, single_atom_matrix, two_atom_matrix, three_atom_matrix, four_atom_matrix, state_to_decimal
export create_matrix_64

"""
    compute_eigenvalues(A::AbstractMatrix)

Compute the eigenvalues of matrix A.

# Arguments
- `A`: A square matrix

# Returns
- A vector containing the eigenvalues of A

# Examples
```julia
julia> A = [1 2; 2 1]
julia> compute_eigenvalues(A)
2-element Vector{Float64}:
 -1.0
  3.0
```
"""

end # module eigenval
