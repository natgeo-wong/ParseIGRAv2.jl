struct IGRAv2DataRaw{ST<:AbstractString,FT<:Real} <: IGRAv2Data
         ID :: ST
       name :: ST
       file :: ST
        lon :: FT
        lat :: FT
          z :: FT
       line :: Vector{Int}
      dates :: Vector{DateTime}
    nlevels :: Vector{Int}
end

struct IGRAv2DataDerived{ST<:AbstractString,FT<:Real} <: IGRAv2Data
         ID :: ST
       name :: ST
       file :: ST
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
)

    zID = zippath(station,path)
    fID = txtpath(station,path)

    zip = ZipFile.Reader(zID)
    zIO = zip.files[1]
    txt = ZipFile.read(zIO,String)
    close(zip)

    @info "$(modulelog()) - Extracting radiosonde data for $(station.ID) from $zID to $fID ..."

    fIO = open(fID,"w")
    write(fIO,txt)
    close(fIO)

end

function read(
    station :: IGRAv2StationDerived;
    path    :: AbstractString = homedir(),
    FT = Float64, ST = String
)

    fID = txtpath(station,path)
    fio = open(fID)
    nobs = 0
    for line in eachline(fio)
        if line[1] == '#'
            nobs += 1
        end
    end
    close(fio)

    igra = IGRAv2DataDerived{ST,FT}(
        station.ID, station.name, fID,
        station.lon, station.lat, station.z,
        zeros(Int,nobs), zeros(DateTime,nobs), zeros(Int,nobs), zeros(Int,nobs)
    )

    @info "$(modulelog()) - Loading radiosonde data information for $(station.ID) ..."

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

function read(
    station :: IGRAv2StationRaw;
    path    :: AbstractString = homedir(),
    FT = Float64, ST = String
)

    fID = txtpath(station,path)
    fio = open(fID)
    nobs = 0
    for line in eachline(fio)
        if line[1] == '#'
            nobs += 1
        end
    end
    close(fio)

    igra = IGRAv2DataRaw{ST,FT}(
        station.ID, station.name, fID,
        station.lon, station.lat, station.z,
        zeros(Int,nobs), zeros(DateTime,nobs), zeros(Int,nobs),
    )

    @info "$(modulelog()) - Loading radiosonde data information for $(station.ID) ..."

    fio = open(fID)
    ii = 0
    iline = 0
    for line in eachline(fio)
        iline += 1
        if line[1] == '#'
            ii += 1

            hr = parse(Int,line[25:26])
            mi = 0
            if hr == 99
                hr = parse(Int,line[28:29])
                mi = parse(Int,line[30:31])
            end
            if mi == 99; mi = 0 end
            if hr == 99; hr = 0 end
            
            igra.dates[ii] = DateTime(
                parse(Int,line[14:17]), parse(Int,line[19:20]),
                parse(Int,line[22:23]), hr, mi
            )
            igra.nlevels[ii] = parse(Int,line[32:36])
            igra.line[ii] = iline
        end
    end
    close(fio)

    return igra

end

function show(io::IO, stn::IGRAv2Data)
    print(
		io,
		"The IGRAv2 Station \"$(stn.ID)\" has the following observations:\n",
		"    Station ID                 (ID) : ", stn.ID,                  '\n',
		"    Station Name             (name) : ", stn.name,                '\n',
		"    Station Coordinates (lon,lat,z) : ", [stn.lon,stn.lat,stn.z], '\n',
        "    Number of Observations          : ", length(stn.line),        '\n',
        "    Start Date/Time                 : ", minimum(stn.dates),      '\n',
        "    End Date/Time                   : ", maximum(stn.dates)
	)
end