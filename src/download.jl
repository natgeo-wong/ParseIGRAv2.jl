function download(
    station :: IGRAv2Station;
    path    :: AbstractString = homedir(),
    derived :: Bool = false
)

    if derived
        mkpath(joinpath(path,"IGRAv2","derived"))
        fzip = joinpath(path,"IGRAv2","derived","$(station.ID).txt.zip")
        download(joinpath(
            station.https,"derived/derived-por",
            "$(station.ID)-drvd.txt.zip"
        ),fzip)
    else
        mkpath(joinpath(path,"IGRAv2","raw"))
        fzip = joinpath(path,"IGRAv2","raw","$(station.ID).txt.zip")
        download(joinpath(
            station.https,"data/data-por",
            "$(station.ID).txt.zip"
        ),fzip)
    end

    @info "$(modulelog()) - Downloaded radiosonde data for $(station.ID) to $fzip"

    return nothing

end