using AnalyzeIGRAv2
using Documenter

DocMeta.setdocmeta!(AnalyzeIGRAv2, :DocTestSetup, :(using AnalyzeIGRAv2); recursive=true)

makedocs(;
    modules=[AnalyzeIGRAv2],
    authors="Nathanael Wong <natgeo.wong@outlook.com>",
    repo="https://github.com/natgeo-wong/AnalyzeIGRAv2.jl/blob/{commit}{path}#{line}",
    sitename="AnalyzeIGRAv2.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://natgeo-wong.github.io/AnalyzeIGRAv2.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/natgeo-wong/AnalyzeIGRAv2.jl",
    devbranch="main",
)
