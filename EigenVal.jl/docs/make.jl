using EigenVal
using Documenter

DocMeta.setdocmeta!(EigenVal, :DocTestSetup, :(using EigenVal); recursive=true)

makedocs(;
    modules=[EigenVal],
    authors="wanda0929 <hwang924@connect.hkust-gz.edu.cn> and contributors",
    sitename="EigenVal.jl",
    format=Documenter.HTML(;
        canonical="https://wanda0929.github.io/EigenVal.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/wanda0929/EigenVal.jl",
    devbranch="main",
)
