using AdiabaticEvolution
using Documenter

DocMeta.setdocmeta!(AdiabaticEvolution, :DocTestSetup, :(using AdiabaticEvolution); recursive=true)

makedocs(;
    modules=[AdiabaticEvolution],
    authors="wanda0929 <hwang924@connect.hkust-gz.edu.cn> and contributors",
    sitename="AdiabaticEvolution.jl",
    format=Documenter.HTML(;
        canonical="https://wanda0929.github.io/AdiabaticEvolution.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/wanda0929/AdiabaticEvolution.jl",
    devbranch="main",
)
