function download(
    station :: IGRAv2Station;
    path    :: AbstractString = homedir(),
    derived :: Bool = false
)

    if derived
        mkpath(joinpath(path,"IGRAv2","derived"))
    else
        mkpath(joinpath(path,"IGRAv2","raw"))
    end
    fzip = zippath(station,path); mkpath(dirname(fzip))
    download(station.https,fzip)

    @info "$(modulelog()) - Downloaded radiosonde data for $(station.ID) to $fzip"

    return nothing

end