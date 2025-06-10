using Documenter
using RydbergPulseDesign

makedocs(
    sitename = "RydbergPulseDesign",
    format = Documenter.HTML(),
    modules = [RydbergPulseDesign],
    pages = [
        "Home" => "index.md",
        "API Reference" => "api.md",
        "Examples" => "examples.md"
    ]
) 