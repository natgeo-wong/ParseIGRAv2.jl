function download(
    station :: IGRAv2Station;
    path    :: AbstractString = homedir(),
    derived :: Bool = false
)

    if derived
        mkpath(joinpath(path,"IGRAv2","derived"))
        download(joinpath(
            station.https,"derived/derived-por",
            "$(station.ID)-drvd.txt.zip"
        ),joinpath(path,"IGRAv2","derived","$(station.ID).txt.zip"))
    else
        mkpath(joinpath(path,"IGRAv2","raw"))
        download(joinpath(
            station.https,"data/data-por",
            "$(station.ID).txt.zip"
        ),joinpath(path,"IGRAv2","raw","$(station.ID).txt.zip"))
    end

    return nothing

end