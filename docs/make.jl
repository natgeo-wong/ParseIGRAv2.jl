using ParseIGRAv2
using Documenter

DocMeta.setdocmeta!(ParseIGRAv2, :DocTestSetup, :(using ParseIGRAv2); recursive=true)

makedocs(;
    modules=[ParseIGRAv2],
    authors="Nathanael Wong <natgeo.wong@outlook.com>",
    repo="https://github.com/natgeo-wong/ParseIGRAv2.jl/blob/{commit}{path}#{line}",
    sitename="ParseIGRAv2.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://natgeo-wong.github.io/ParseIGRAv2.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/natgeo-wong/ParseIGRAv2.jl",
    devbranch="main",
)
