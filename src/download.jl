function download(
    station :: IGRAv2Station;
    path    :: AbstractString = homedir(),
    derived :: Bool = false
)

    fzip = zippath(station,path); mkpath(dirname(fzip))
    download(station.https,fzip)

    @info "$(modulelog()) - Downloaded radiosonde data for $(station.ID) to $fzip"

    return nothing

end