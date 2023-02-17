struct IGRAv2Data{ST<:AbstractString,FT<:Real}
         ID :: ST
       name :: ST
        lon :: FT
        lat :: FT
          z :: FT
       line :: Vector{Int}
      dates :: Vector{DateTime}
    nlevels :: Vector{Int}
        pwv :: Vector{Int}
end


function extract(
    station :: IGRAv2Station;
    path    :: AbstractString = homedir(),
    derived :: Bool = false
)

    if derived
        zID = joinpath(path,"IGRAv2","derived","$(station.ID).txt.zip")
        fID = joinpath(path,"IGRAv2","derived","$(station.ID).txt")
    else
        zID = joinpath(path,"IGRAv2","raw","$(station.ID).txt.zip")
        fID = joinpath(path,"IGRAv2","raw","$(station.ID).txt")
    end

    zip = ZipFile.Reader(zID)
    zIO = zip.files[1]
    txt = read(zIO,String)

    fIO = open(fID,"w")
    write(fIO,txt)
    close(fIO)

end

function read(
    station :: IGRAv2Station;
    path    :: AbstractString = homedir(),
    derived :: Bool = false,
    FT = Float64, ST = String
)

    if derived
        fID = joinpath(path,"IGRAv2","derived","$(station.ID).txt")
    else
        fID = joinpath(path,"IGRAv2","raw","$(station.ID).txt")
    end

    fio = open(fID)
    nobs = 0
    for line in eachline(fio)
        if line[1] == '#'
            nobs += 1
        end
    end
    close(fio)

    igra = IGRAv2Data{ST,FT}(
        station.ID, station.name, station.lon, station.lat, station.z,
        zeros(Int,nobs), zeros(DateTime,nobs), zeros(Int,nobs), zeros(Int,nobs)
    )

    fio = open(fID)
    ii = 0
    iline = 0
    for line in eachline(fio)
        iline += 1
        if line[1] == '#'
            ii += 1
            igra.dates[ii] = DateTime(
                parse(Int,line[14:17]), parse(Int,line[19:20]),
                parse(Int,line[22:23]), parse(Int,line[25:26])
            )
            igra.nlevels[ii] = parse(Int,line[32:36])
            igra.pwv[ii] = parse(Int,line[38:43])
            igra.line[ii] = iline
        end
    end
    close(fio)

    return igra

end