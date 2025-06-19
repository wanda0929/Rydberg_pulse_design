using OptimalParity
using Documenter

DocMeta.setdocmeta!(OptimalParity, :DocTestSetup, :(using OptimalParity); recursive=true)

makedocs(;
    modules=[OptimalParity],
    authors="wanda0929 <hwang924@connect.hkust-gz.edu.cn> and contributors",
    sitename="OptimalParity.jl",
    format=Documenter.HTML(;
        canonical="https://wanda0929.github.io/OptimalParity.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/wanda0929/OptimalParity.jl",
    devbranch="main",
)
